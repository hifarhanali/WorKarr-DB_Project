let glass = document.querySelector('.glass');
let slider = document.querySelector('.slider');
let navBar = document.querySelector('nav');

let home_content = document.querySelector('#home-content');


let tl = new TimelineMax();
tl.fromTo(glass, 1, { height: '0%' }, { height: '80vh', ease: Power2.easeInOut })
    .fromTo(glass, 1.2, { width: '90%' }, { width: '70%', ease: Power2.easeInOut })
    .fromTo(home_content, 1.5, { opacity: '0', x: '-100%' }, { opacity: '1', x: '0%' }, '-=1.5')
    .fromTo(navBar, 2, { opacity: 0 }, { opacity: 1 }, '-=1');