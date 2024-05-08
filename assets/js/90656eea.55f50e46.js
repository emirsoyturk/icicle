"use strict";(self.webpackChunkdocusaurus=self.webpackChunkdocusaurus||[]).push([[846],{5680:(e,t,i)=>{i.d(t,{xA:()=>p,yg:()=>v});var r=i(6540);function n(e,t,i){return t in e?Object.defineProperty(e,t,{value:i,enumerable:!0,configurable:!0,writable:!0}):e[t]=i,e}function a(e,t){var i=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),i.push.apply(i,r)}return i}function o(e){for(var t=1;t<arguments.length;t++){var i=null!=arguments[t]?arguments[t]:{};t%2?a(Object(i),!0).forEach((function(t){n(e,t,i[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(i)):a(Object(i)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(i,t))}))}return e}function c(e,t){if(null==e)return{};var i,r,n=function(e,t){if(null==e)return{};var i,r,n={},a=Object.keys(e);for(r=0;r<a.length;r++)i=a[r],t.indexOf(i)>=0||(n[i]=e[i]);return n}(e,t);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(r=0;r<a.length;r++)i=a[r],t.indexOf(i)>=0||Object.prototype.propertyIsEnumerable.call(e,i)&&(n[i]=e[i])}return n}var l=r.createContext({}),s=function(e){var t=r.useContext(l),i=t;return e&&(i="function"==typeof e?e(t):o(o({},t),e)),i},p=function(e){var t=s(e.components);return r.createElement(l.Provider,{value:t},e.children)},u="mdxType",m={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},d=r.forwardRef((function(e,t){var i=e.components,n=e.mdxType,a=e.originalType,l=e.parentName,p=c(e,["components","mdxType","originalType","parentName"]),u=s(i),d=n,v=u["".concat(l,".").concat(d)]||u[d]||m[d]||a;return i?r.createElement(v,o(o({ref:t},p),{},{components:i})):r.createElement(v,o({ref:t},p))}));function v(e,t){var i=arguments,n=t&&t.mdxType;if("string"==typeof e||n){var a=i.length,o=new Array(a);o[0]=d;var c={};for(var l in t)hasOwnProperty.call(t,l)&&(c[l]=t[l]);c.originalType=e,c[u]="string"==typeof e?e:n,o[1]=c;for(var s=2;s<a;s++)o[s]=i[s];return r.createElement.apply(null,o)}return r.createElement.apply(null,i)}d.displayName="MDXCreateElement"},1296:(e,t,i)=>{i.r(t),i.d(t,{assets:()=>l,contentTitle:()=>o,default:()=>m,frontMatter:()=>a,metadata:()=>c,toc:()=>s});var r=i(8168),n=(i(6540),i(5680));i(1873);const a={},o="ICICLE Primitives",c={unversionedId:"icicle/primitives/overview",id:"icicle/primitives/overview",title:"ICICLE Primitives",description:"This section of the documentation is dedicated to the ICICLE primitives, we will cover the usage and internal details of our primitives such as hashing algorithms, MSM and NTT.",source:"@site/docs/icicle/primitives/overview.md",sourceDirName:"icicle/primitives",slug:"/icicle/primitives/overview",permalink:"/icicle/primitives/overview",editUrl:"https://github.com/ingonyama-zk/icicle/tree/main/docs/icicle/primitives/overview.md",tags:[],version:"current",lastUpdatedBy:"nonam3e",lastUpdatedAt:1715199539,formattedLastUpdatedAt:"5/8/2024",frontMatter:{},sidebar:"GettingStartedSidebar",previous:{title:"ICICLE Core",permalink:"/icicle/core"},next:{title:"MSM - Multi scalar multiplication",permalink:"/icicle/primitives/msm"}},l={},s=[{value:"Supported primitives",id:"supported-primitives",level:2}],p={toc:s},u="wrapper";function m(e){let{components:t,...i}=e;return(0,n.yg)(u,(0,r.A)({},p,i,{components:t,mdxType:"MDXLayout"}),(0,n.yg)("h1",{id:"icicle-primitives"},"ICICLE Primitives"),(0,n.yg)("p",null,"This section of the documentation is dedicated to the ICICLE primitives, we will cover the usage and internal details of our primitives such as hashing algorithms, MSM and NTT."),(0,n.yg)("h2",{id:"supported-primitives"},"Supported primitives"),(0,n.yg)("ul",null,(0,n.yg)("li",{parentName:"ul"},(0,n.yg)("a",{parentName:"li",href:"/icicle/primitives/msm"},"MSM")),(0,n.yg)("li",{parentName:"ul"},(0,n.yg)("a",{parentName:"li",href:"/icicle/primitives/ntt"},"NTT")),(0,n.yg)("li",{parentName:"ul"},(0,n.yg)("a",{parentName:"li",href:"/icicle/primitives/keccak"},"Keccak Hash")),(0,n.yg)("li",{parentName:"ul"},(0,n.yg)("a",{parentName:"li",href:"/icicle/primitives/poseidon"},"Poseidon Hash"))))}m.isMDXComponent=!0},1873:(e,t,i)=>{i(6540)}}]);