/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{d as n}from"./Blank.js";function a(t){const o=atob(t),e=Uint8Array.from(o,r=>r.charCodeAt(0));return new TextDecoder().decode(e)}function d(t){try{return n(t)?void 0:JSON.parse(a(t))}catch{return}}function s(t){const o=new TextEncoder().encode(t);let e="";for(const r of o)e+=String.fromCharCode(r);return btoa(e)}export{d,s as u};
