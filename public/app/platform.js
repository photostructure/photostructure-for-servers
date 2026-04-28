/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{b as s,P as a}from"./Array.js";import{l as t}from"./Lazy.js";const o=t(()=>s(globalThis?.navigator?.userAgent));function e(n){return document?.body?.classList?.contains(n)===!0}const r=a(()=>e("electron"));a(()=>e("linux"));const l=a(()=>e("mac"));a(()=>e("win"));const u=a(()=>e("ipad")||e("safari")||e("iphone")),b=a(()=>e("ipad")||e("safari")&&!e("iphone")&&navigator?.maxTouchPoints>1?(document?.body?.classList?.add("ipad"),document?.body?.classList?.remove("mac"),!0):!1);function d(){return e("enable-archive")}function m(){return e("enable-remove")}function f(){return e("enable-delete")}const p=a(()=>/\bmacintosh\b|mac os x/i.exec(o())!=null);export{l as a,e as b,p as c,u as d,m as e,f,d as g,b as h,r as i,o as u};
