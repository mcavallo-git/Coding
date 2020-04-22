

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


<!--
------------------------------------------------------------

 Citation(s)

   stackoverflow.com  |  "bash - How to check if running in Cygwin, Mac or Linux? - Stack Overflow"  |  https://stackoverflow.com/a/3466183

------------------------------------------------------------
-->