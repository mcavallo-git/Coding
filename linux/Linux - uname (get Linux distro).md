

# [uname(1) - Linux man page](https://linux.die.net/man/1/uname)
***


### Get Current Linux Distribution
```

case "$(uname -s)" in
    Linux*)     THIS_LINUX_DISTRO="Linux";;
    Darwin*)    THIS_LINUX_DISTRO="Mac";;
    CYGWIN*)    THIS_LINUX_DISTRO="Cygwin";;
    MINGW*)     THIS_LINUX_DISTRO="MinGw";;
    *)          THIS_LINUX_DISTRO="UNKNOWN:${unameOut}";;
esac

echo ${THIS_LINUX_DISTRO};

```

***

##### Reference(s)
######  case-esac approach -  Cited on 2018-10-26  -  Thanks to user 'paxdiablo' on [Stack Overflow](https://stackoverflow.com/questions/3466166]
