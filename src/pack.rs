use super::error::DotsResult;
use std::process::{Command, Stdio};

enum PackageManager {
    Brew,
    Cargo,
    Choco,
    Yum,
    Apt,
    AptGet,
}

impl PackageManager {
    fn command(&self) -> Command {
        Command::new(match self {
            Self::Brew => "brew",
            Self::Cargo => "cargo",
            Self::Choco => "choco",
            Self::Yum => "yum",
            Self::Apt => "apt",
            Self::AptGet => "apt-get",
        })
    }

    pub fn install(&self) -> DotsResult<()> {
        match self {
            Self::Brew => Ok(()),
            Self::Cargo => Ok(()),
            Self::Choco => Ok(()),
            Self::Yum => Ok(()),
            Self::Apt => Ok(()),
            Self::AptGet => Ok(()),
        }
    }
}

pub enum Shell {
    Sh,
    Bash,
    Zsh,
    Powershell,
}

impl Shell {
    #[inline(always)]
    fn path(&self) -> &str {
        match self {
            Self::Sh => "sh",
            Self::Bash => "bash",
            Self::Zsh => "zsh",
            Self::Powershell => "pwsh",
        }
    }

    fn command(&self) -> Command {
        Command::new(self.path())
    }

    pub fn chsh(&self) -> DotsResult<()> {
        let output = Command::new("which")
            .arg(self.path())
            .stdout(Stdio::piped())
            .output()
            .expect("Failed to locate shell");
        let path = String::from_utf8_lossy(&output.stdout);
        Command::new("chsh")
            .arg("-s")
            .arg(path.as_ref())
            .output()
            .expect("Failed to change shell");
        Ok(())
    }

    pub fn install(&self) -> DotsResult<()> {
        match self {
            Self::Sh => Ok(()),
            Self::Bash => Ok(()),
            Self::Zsh => Ok(()),
            Self::Powershell => Ok(()),
        }
    }
}

fn install_essential() {
    // TODO:
    // cargo
    // zsh
    // brew
    // git
    // git-delta
    // bat
    // choco
}
