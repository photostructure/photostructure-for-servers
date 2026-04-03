/**
 * Copyright © 2026, PhotoStructure Inc. All rights reserved.
 *
 * BY USING THIS SOFTWARE, YOU ACCEPT ALL OF THE TERMS IN
 * https://photostructure.com/eula
 * IF YOU DO NOT ACCEPT THESE TERMS, DO NOT USE THIS SOFTWARE
 */
import"./Array.js";function u(s,t,e){const n=t.global?t:new RegExp(t.source,t.flags+"g");return s.replace(n,(...l)=>{const r=l.slice(0,-2);return r.index=l[l.length-2],r.input=l[l.length-1],e(r)})}function d(s){let t=s.replace(/</g,"&lt;").replace(/\[br\]/gi,"<br>").replace(/\[p\]/gi,"<p>").replace(/\[\/p\]/gi,"</p>").replace(/^---$/gm,"<hr/>").replace(/^ *- (.*)$/gm,(e,n)=>"<li>"+n.trim()+"</li>");return t=u(t,/```([^`]+)```/g,e=>`<code>${e[1]}</code>`),t=u(t,/\*\*([^*]+)\*\*/,e=>`<b>${e[1]}</b>`),t=u(t,/\[([^\]]+)\]\(([^)]+)\)/g,e=>{const n=e[1],l=e[2],r=l.replace(/"/g,"&quot;"),i=r.startsWith("/");return!i&&!/^(?:https?:|mailto:)/i.test(l)?n:i?`<a href="${r}">${n}</a>`:`<a href="${r}" target="_blank" rel="noopener">${n}</a>`}),t=b(t),t}function f(s){const t=s.trim(),e=t.startsWith(":"),n=t.endsWith(":");return e&&n?"center":n?"right":"left"}function m(s){return s.split("|").map(f)}function c(s,t,e){return"<tr>"+s.map((n,l)=>{const r=e[l];return`<${t}${r==="center"?' class="ta-center"':r==="right"?' class="ta-right"':""}>${n}</${t}>`}).join("")+"</tr>"}function g(s){return s.split(new RegExp("(?<!\\\\)\\|")).map(t=>t.trim().replace(/\\\|/g,"|"))}function b(s){const t=s.split(`
`),e=[];let n=!1,l=null,r=!1,i=[];for(const o of t){const p=o.match(/^\|(.+)\|$/);if(p!=null){const a=p[1];if(/^[-:\s|]+$/.test(a)){i=m(a),l!=null&&(e.push(c(l,"th",i)),l=null,r=!0);continue}n||(e.push('<table class="bmd">'),n=!0,i=[],r=!1);const h=g(a);!r&&l==null?l=h:(l!=null&&(e.push(c(l,"th",i)),l=null,r=!0),e.push(c(h,"td",i)))}else n&&(l!=null&&(e.push(c(l,"th",i)),l=null),e.push("</table>"),n=!1),e.push(o)}return n&&(l!=null&&e.push(c(l,"th",i)),e.push("</table>")),e.join(`
`)}export{d as m};
