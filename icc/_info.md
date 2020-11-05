# ICC Profiles

The profiles in this directory are open source and unhindered by licensing,
thanks to <https://github.com/saucecontrol/Compact-ICC-Profiles>

## How is this used by PhotoStructure?

These profiles are used by the `iccProfileMappings` library setting.

When PhotoStructure finds a value for the `ProfileDescription` tag in images, it
matches against the `iccProfileMappings` values to find an ICC profile to embed
in preview images.

As of 20201029, PhotoStructure only supports, by default, the `Display P3`
profile, and embeds the `DisplayP3Compat-v2-magic.icc` file. All other files are
forced into the sRGB color gamut.

Note that many browsers can't, or don't, render ICC profiles correctly. Check
your browser with <https://littlecms.com/blog/2020/09/09/browser-check/>.

## How to edit settings

See <https://photostructure.com/getting-started/advanced-settings/> for more
information on how to edit PhotoStructure's settings.

## Research

In looking at over 5,000 example images, all from unique camera makes and
models, most images are _not_ encoded with a `ProfileDescription`, and those
that are, are encoded with an sRGB profile or variant:

```
$ exiftool -q -r -ProfileDescription ~/src/test-images/ 2>&1 | grep -v Warning | sort | uniq -c | sort -bnr

1654 : sRGB IEC61966-2.1
  39 : Camera RGB Profile
  22 : Display P3
  10 : Adobe RGB (1998)
   8 : sRGB IEC61966-2-1 black scaled
   6 : sRGB (Minolta Co.,Ltd.)
   6 : sRGB built-in
   6 : Nikon sRGB 4.0.0.3001
   5 : Dot Gain 20%
   4 : Dot Gain 15%
   4 : Color LCD
   3 : U.S. Web Coated (SWOP) v2
   3 : Nikon sRGB 4.0.0.3002
   3 : Nikon Adobe RGB 4.0.0.3000
```
