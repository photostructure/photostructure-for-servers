/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{l as a}from"./Lazy.js";import{c as s}from"./Blank.js";const t=a(()=>s(globalThis?.navigator?.userAgent));function e(n){return document?.body?.classList?.contains(n)===!0}const c=a(()=>e("electron"));a(()=>e("linux"));const r=a(()=>e("mac"));a(()=>e("win"));const l=a(()=>e("ipad")||e("safari")||e("iphone")),u=a(()=>e("ipad")||e("safari")&&!e("iphone")&&navigator?.maxTouchPoints>1?(document?.body?.classList?.add("ipad"),document?.body?.classList?.remove("mac"),!0):!1);function m(){return e("enable-archive")}function b(){return e("enable-remove")}function d(){return e("enable-delete")}const f=a(()=>/\bmacintosh\b|mac os x/i.exec(t())!=null);export{r as a,e as b,u as c,l as d,b as e,d as f,m as g,f as h,c as i,t as u};
