/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{m as e,b as r}from"./Blank.js";import{q as l}from"./fe.js";function h(){for(const t of l("a[href]"))e(t.href,i=>{const o=t.getAttribute("href"),a=o!=null&&o.startsWith("#"),s=o!=null&&o.startsWith("/"),n=!a&&!s;n&&(t.target="_blank"),r(t.title)&&!a&&(t.title="Click to open "+i+(n?" in a new window":""))})}export{h as a};
