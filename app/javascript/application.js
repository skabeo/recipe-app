// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function () {
  const modal = document.getElementById("myModal");
  const openModalButton = document.getElementById("openModalButton");
  const closeModalButton = document.getElementById("closeModalButton");
  const linkInsideModal = document.querySelector("#myModal a");

  // Show the modal when the "Open Modal" button is clicked
  openModalButton.addEventListener("click", function () {
    modal.style.display = "flex";
  });

  // Hide the modal when the close button is clicked
  closeModalButton.addEventListener("click", function () {
    modal.style.display = "none";
  });

  // Hide the modal when clicking outside the modal content
  window.addEventListener("click", function (event) {
    if (event.target === modal) {
      modal.style.display = "none";
    }
  });

  linkInsideModal.addEventListener("click", function (event) {
    event.preventDefault(); // Prevent the link from following its URL
    modal.style.display = "none"; // Close the modal
    const linkTarget = event.target.getAttribute("href");
    window.location.href = linkTarget; // Navigate to the link's URL manually
  });
});
