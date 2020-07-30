# DCRAW: digital camera raw image decoder

(this is included in the server version because, as of 20200714, Chocolatey
doesn't have a package for dcraw)

## Static build using Visual Studio 2015's command line

1. start > visual studio 2015 > Open Developer Command Prompt

2. [RTFM](https://msdn.microsoft.com/en-us/library/wk21sfcf.aspx), then compile

```sh
cl dcraw.c -DNODEPS -D__MINGW32__ -DWIN32 /Ox /link /WHOLEARCHIVE
```