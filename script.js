function deploy() {
  const status = document.getElementById("status");
  status.textContent = "✅ Deployment successful via GitHub Actions!";
  status.style.color = "green";
}
