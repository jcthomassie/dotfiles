use super::error::DotsResult;
use super::link::Link;
use serde::Deserialize;
use std::fs::File;
use std::io::BufReader;
use std::path::PathBuf;
use whoami;

#[derive(Debug, PartialEq, Deserialize)]
pub struct Repo {
    local: String,
    remote: String,
}

#[derive(Debug, PartialEq, Deserialize)]
pub struct Locale {
    user: Option<String>,
    platform: Option<String>,
    distro: Option<String>,
}

impl Locale {
    pub fn auto() -> Self {
        Self {
            user: Some(whoami::username()),
            platform: Some(format!("{:?}", whoami::platform())),
            distro: whoami::distro().split(" ").next().map(String::from),
        }
    }

    pub fn is_subset(&self, other: &Self) -> bool {
        (self.user.is_none() || self.user == other.user)
            && (self.platform.is_none() || self.platform == other.platform)
            && (self.distro.is_none() || self.distro == other.distro)
    }
}

#[derive(Debug, PartialEq, Deserialize)]
#[serde(rename_all(deserialize = "snake_case"))]
pub enum Case {
    Local { spec: Locale, build: Vec<BuildUnit> },
    Default { build: Vec<BuildUnit> },
}

#[derive(Debug, PartialEq, Deserialize)]
#[serde(rename_all(deserialize = "snake_case"))]
pub enum BuildUnit {
    Case(Vec<Case>),
    Link(Vec<Link>),
}

impl BuildUnit {
    // Recursively remove all invalid build cases
    // Returns True when the build ends up empty
    pub fn prune(&mut self) -> bool {
        match self {
            Self::Case(cv) => {
                // TODO: create static locale
                let locale = Locale::auto();
                let mut default = true;
                cv.drain_filter(|scope| match scope {
                    Case::Local { spec, build } if spec.is_subset(&locale) => {
                        default = false;
                        build.drain_filter(|u| u.prune());
                        build.is_empty()
                    }
                    Case::Default { build } if default => {
                        build.drain_filter(|u| u.prune());
                        build.is_empty()
                    }
                    _ => true,
                });
                cv.is_empty()
            }
            Self::Link(_) => false,
        }
    }
}

#[derive(Debug, PartialEq, Deserialize)]
pub struct Build {
    repo: Repo,
    build: Vec<BuildUnit>,
}

impl Build {
    pub fn prune(&mut self) -> bool {
        self.build.drain_filter(|u| u.prune());
        self.build.is_empty()
    }

    // pub fn apply<T>(&self, f: fn(&BuildCase) -> T) -> Vec<T> {
    //     let locale = BuildCase::auto();
    //     let mut default = true;
    //     self.build
    //         .iter()
    //         .filter_map(|scope| match scope {
    //             BuildScope::All(c) => Some(f(c)),
    //             BuildScope::Case(c) if c == locale => {
    //                 default = false;
    //                 Some(f(c))
    //             }
    //             BuildScope::Default(c) if default => Some(f(c)),
    //             BuildScope::Default(_) => {
    //                 default = true;
    //                 None
    //             }
    //             _ => None,
    //         })
    //         .collect()
    // }
}

pub fn parse(path: PathBuf) -> DotsResult<Build> {
    let file = File::open(path)?;
    let reader = BufReader::new(file);
    let build: Build = serde_yaml::from_reader(reader)?;
    Ok(build)
}
