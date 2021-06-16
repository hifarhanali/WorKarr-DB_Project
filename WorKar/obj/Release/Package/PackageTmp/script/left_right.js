const prev = document.querySelector(".prev");
const next = document.querySelector(".next");
const cards = document.querySelectorAll('.card-container');
let currentIndex = 0;

next.addEventListener("click", () => {
    if (currentIndex == cards.length - 1) {
        currentIndex = 0;
        document.querySelector(".active-page-no").classList.remove("active-page-no");
        cards[currentIndex].classList.add("active-page-no");
        return;
    }

    if (currentIndex < cards.length) {
        document.querySelector(".active-page-no").classList.remove("active-page-no");
        currentIndex++;
        cards[currentIndex].classList.add("active-page-no");
    }
})

prev.addEventListener("click", () => {
    if (currentIndex == 0) {
        currentIndex = cards.length - 1;
        document.querySelector(".active-page-no").classList.remove("active-page-no");
        cards[currentIndex].classList.add("active-page-no");
        return;
    }

    if (currentIndex < cards.length) {
        document.querySelector(".active-page-no").classList.remove("active-page-no");
        currentIndex--;
        cards[currentIndex].classList.add("active-page-no");
    }
})