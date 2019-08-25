# Static build

* ImageMagick pulled in `opencl` and `clew`. Nope.
* msys and cygwin need their runtime dll. Nope.

## Using Visual Studio 2015's command line

1. start > visual studio 2015 > Open Developer Command Prompt

1. Apply this patch:

```diff
--- dcraw_20170210085513.c      2017-02-10 08:55:13.486682100 -0800
+++ ../dcraw.c  2017-02-10 08:55:37.000000000 -0800
@@ -42,7 +42,7 @@
 #include <time.h>
 #include <sys/types.h>

-#if defined(DJGPP) || defined(__MINGW32__)
+#if defined(DJGPP) || defined(__MINGW32__) || defined(WIN32)
 #define fseeko fseek
 #define ftello ftell
 #else
```

1. [RTFM](https://msdn.microsoft.com/en-us/library/wk21sfcf.aspx), then compile

```sh
cl dcraw.c -DNODEPS -DWIN32 /Ox /link /WHOLEARCHIVE
```