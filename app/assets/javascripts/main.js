const description = document.querySelectorAll('.description');
const button = document.querySelectorAll('.button');

button.forEach(node => {
    node.addEventListener("click", event => {
         console.log(event.target)
         console.log(event.currentTarget.nextElementSibling.children[1])
         event.currentTarget.nextElementSibling.children[1].classList.toggle('visibility')
    });
    
});