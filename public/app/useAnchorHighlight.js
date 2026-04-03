/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{w as h,D as v,c as g,b as m,n as p}from"./toast.js";function I(){const e=window.location.hash;return!e||e.length<=1?null:decodeURIComponent(e.slice(1))}function T(e){const{validSectionIds:u,collapsedRefs:r,ready:o,onTargetFound:i}=e,t=m(null);function s(){const n=I();return n==null||u!=null&&!u.includes(n)?null:n}async function a(n){await p();const l=document.getElementById(n);l!=null&&(i?.(l),l.scrollIntoView({behavior:"smooth",block:"start"}))}function c(n){if(r!=null)for(const[l,f]of Object.entries(r))f.value=l!==n}function d(){const n=s();n!=null&&(t.value=n,c(n),(o==null||o.value)&&a(n))}return o!=null&&h(o,n=>{n&&t.value!=null&&(c(t.value),a(t.value))}),v(()=>{d()}),{targetSectionId:g(()=>t.value)}}export{I as p,T as u};
