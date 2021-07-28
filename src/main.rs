use clap::{crate_version, App, AppSettings, Arg};
use shellexpand;
use std::io::{Error, ErrorKind};
use std::path::PathBuf;
use symlink;

#[inline]
fn parse_path(path: &str) -> PathBuf {
    PathBuf::from(shellexpand::full(path).unwrap().as_ref())
}

enum LinkStatus {
    Exists,
    NotExists,
    Invalid(Error),
}

struct Link {
    // head@ -> tail
    head: PathBuf,
    tail: PathBuf,
}

impl Link {
    // Performs shell expansion on input paths
    fn new(head: &str, tail: &str) -> Self {
        Link {
            head: parse_path(head),
            tail: parse_path(tail),
        }
    }

    fn status(&self) -> LinkStatus {
        if self.head.exists() {
            return match self.head.read_link() {
                Ok(target) if target == self.tail => LinkStatus::Exists,
                Ok(_) => LinkStatus::Invalid(Error::new(
                    ErrorKind::AlreadyExists,
                    "link source points to wrong target",
                )),
                Err(e) => LinkStatus::Invalid(e),
            };
        }
        LinkStatus::NotExists
    }

    fn link(&self) -> Result<(), Error> {
        match self.status() {
            LinkStatus::Exists => Ok(()),
            LinkStatus::NotExists => {
                println!("Linking {:?}@->{:?}", self.head, self.tail);
                symlink::symlink_file(self.tail.as_path(), self.head.as_path())
            }
            LinkStatus::Invalid(e) => Err(e),
        }
    }

    fn unlink(&self) -> Result<(), Error> {
        match self.status() {
            LinkStatus::Exists => {
                println!("Unlinking {:?}@->{:?}", self.head, self.tail);
                symlink::remove_symlink_file(self.head.as_path())
            }
            _ => Ok(()),
        }
    }
}

fn main() -> Result<(), Error> {
    let matches = App::new("dots")
        .version(crate_version!())
        .setting(AppSettings::ArgRequiredElseHelp)
        .subcommand(App::new("install").about("install dotfiles"))
        .subcommand(App::new("uninstall").about("uninstall dotfiles"))
        .arg(
            Arg::new("root")
                .about("dotfile repo root directory")
                .short('r')
                .long("root")
                .default_value("$HOME/dotfiles"),
        )
        .get_matches();

    let root = parse_path(matches.value_of("root").unwrap());
    println!("ROOT: {:?}", root);

    match matches.subcommand_name() {
        Some("install") => {
            println!("Installing dotfiles...");
            Link::new("~/test-source", "~/test-target").link()
        }
        Some("uninstall") => {
            println!("Unstalling dotfiles...");
            Link::new("~/test-source", "~/test-target").unlink()
        }
        _ => unreachable!(),
    }
}
