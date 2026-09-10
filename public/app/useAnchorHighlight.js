/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{D as e,W as t,et as n,st as r,z as i}from"./Spinner.js";function a(){let e=window.location.hash;return!e||e.length<=1?null:decodeURIComponent(e.slice(1))}function o(o){let{validSectionIds:s,collapsedRefs:c,ready:l,onTargetFound:u}=o,d=r(null);function f(){let e=a();return e==null||s!=null&&!s.includes(e)?null:e}async function p(e){await i();let t=document.getElementById(e);t!=null&&(u?.(t),t.scrollIntoView({behavior:`smooth`,block:`start`}))}function m(e){if(c!=null)for(let[t,n]of Object.entries(c))n.value=t!==e}function h(){let e=f();e!=null&&(d.value=e,m(e),(l==null||l.value)&&p(e))}return l!=null&&n(l,e=>{e&&d.value!=null&&(m(d.value),p(d.value))}),t(()=>{h()}),{targetSectionId:e(()=>d.value)}}export{o as n,a as t};