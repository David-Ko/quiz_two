// document.querySelectorAll(".blah").forEach(node => {
//     node.addEventListener("mouseenter", event => {
//         // console.log(`${event} was clicked`)
//         event.currentTarget.classList.add("pink")
//     });
//     node.addEventListener("mouseleave", event => {
//         // console.log(`${event} was clicked`)
//         event.currentTarget.classList.remove("pink")
//     });
// });

const parent = document.querySelector("#parent")
const blah = parent.querySelector(".class")

blah.addEventListener('click', event=>{event.target.closest("p").add("hide")})