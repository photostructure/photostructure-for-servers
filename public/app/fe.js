/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import{m as o}from"./Maybe.js";function m(n){return document.querySelector(n)}function l(n){return document.querySelectorAll(n)}function i(n,t){return n?.matches?.(t)?n:o(n?.parentElement,e=>i(e,t))}function u(n,t){const e=n?.previousElementSibling;return o(e,r=>r.matches(t)?r:u(r,t))}function c(n,t){const e=n?.nextElementSibling;return o(e,r=>r.matches(t)?r:c(r,t))}function a(n,t="smooth"){o(document.querySelector(n),e=>e.scrollIntoView({behavior:t}))}export{m as $,i as a,c as n,u as p,l as q,a as s};
