let ham_btn = document.getElementById('btn_hamBurgerID');
let sidebar = document.getElementById('sidebar-left-sec');


ham_btn.addEventListener('click', () =>
{
        sidebar.classList.toggle("sidebar-hide");
    if ((sidebar.classList.contains('sidebar-hide')) || (localStorage.getItem("sidebar") === "closed")) {
        closeNav();
        document.getElementById('right-section-containerID').classList.toggle("sidebar-hide-right-section-width");        
    }
    else {
        openNav();
    }
}, false);


function openNav() {
    if (typeof (Storage) !== "undefined") {
        // Save the state of the sidebar as "open"
        localStorage.setItem("sidebar", "opened");
    }
}

function closeNav() {
    if (typeof (Storage) !== "undefined") {
        // Save the state of the sidebar as "open"
        localStorage.setItem("sidebar", "closed");
    }
}