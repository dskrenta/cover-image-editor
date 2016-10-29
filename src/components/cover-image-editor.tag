<cover-image-editor>
  <div class="container">
    <img src="http://www.placehold.it/200x200" />
    <table onclick={insert}>
      <tr>
        <td data-direction="NorthWest" onclick={handler}></td>
        <td data-direction="North" onclick={handler}></td>
        <td data-direction="NorthEast" onclick={handler}></td>
      </tr>
      <tr>
        <td data-direction="West" onclick={handler}></td>
        <td data-direction="Center" onclick={handler}></td>
        <td data-direction="East" onclick={handler}></td>
      </tr>
      <tr>
        <td data-direction="SouthWest" onclick={handler}></td>
        <td data-direction="South" onclick={handler}></td>
        <td data-direction="SouthEast" onclick={handler}></td>
      </tr>
    </table>
    <span id="indicator">X</span>
  </div>

  <h1>{ direction }</h1>

  <style>
    .container {
      position: relative;
      width: 200px;
      height: 200px;
    }

    img {
      position: absolute;
      width: 200px;
      height: 200px;
    }

    table {
      position: absolute;
      width: 200px;
      height: 200px;
    }

    span {
      top: 90px;
      left: 90px;
      position: relative;
      width: 10px;
      height: 10px;
      background-color: red;
      border-radius: 1px;
    }
  </style>

  <script>
    const self = this;
    this.direction = 'Center';

    this.on('mount', () => {
      self.indicator = document.getElementById('indicator');
    });

    insert (event) {
      self.indicator.style.top = event.clientY - 5;
      self.indicator.style.left = event.clientX - 5;
    }

    handler (event) {
      self.direction = event.target.dataset.direction;
      self.update();
    }
  </script>
</cover-image-editor>
