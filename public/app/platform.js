/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{V as e}from"./Array.js";import{O as t,t as n}from"./Lazy.js";var r=n(()=>e(globalThis?.navigator?.userAgent));function i(e){return!0===document?.body?.classList?.contains(e)}var a=t(()=>i(`electron`));t(()=>i(`linux`));var o=t(()=>i(`mac`));t(()=>i(`win`));var s=t(()=>i(`ipad`)||i(`safari`)||i(`iphone`)),c=t(()=>i(`ipad`)||i(`safari`)&&!i(`iphone`)&&navigator?.maxTouchPoints>1?(document?.body?.classList?.add(`ipad`),document?.body?.classList?.remove(`mac`),!0):!1);function l(){return i(`enable-archive`)}function u(){return i(`enable-remove`)}function d(){return i(`enable-delete`)}var f=t(()=>/\bmacintosh\b|mac os x/i.exec(r())!=null);export{c as a,o as c,u as i,f as l,l as n,s as o,d as r,a as s,i as t,r as u};