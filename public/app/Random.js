/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import"./Blank.js";function d(t,r){return Math.floor(Math.random()*(r-t))+t}function h(t,r,n){return n==null||n.length===0?d(t,r):f(t,r,1)[0]}function f(t,r,n,l){if(t=Math.ceil(t),r=Math.floor(r),r<t)throw new Error(`randomInts(): invalid range: ${t} > ${r}`);const o=r-t,e=new Set([]);if(r===t&&o===0&&e.size===0&&n===1)return[t];const a=o-e.size;if(n>a)throw new Error(`randomInts(): cannot satisfy request: ${JSON.stringify({max:r,min:t,range:o,size:n,slotsRemaining:a})}`);const s=new Set;for(;s.size<n;){const c=d(t,r);e.has(c)||s.add(c)}return[...s]}export{h as r};
