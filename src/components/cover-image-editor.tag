<cover-image-editor>
  <div class="container">
    <img class="preview" src="http://www.placehold.it/200x200" />
    <table class="grid" onclick={insert}>
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
    <input type="range" min="100" max="500" onchange={magnify}></input>
    <h1>{ direction }</h1>
    <virtual each={partnerCrops}>
      <img height="200px" src="http://node-image-pipeline.us-west-1.elasticbeanstalk.com/crop/{id}/{direction}/{width}/{height}" />
    </virtual>

  <style>
    .container {
      position: relative;
      width: 200px;
      height: 200px;
    }

    .preview {
      position: absolute;
      width: 200px;
      height: 200px;
    }

    .grid {
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
    this.id = 'G9F43EV646AG1CBP';
    this.partnerCrops = [
      {width: 500, height: 500},
      {width: 400, height: 500},
      {width: 500, height: 700}
    ]

    this.on('mount', () => {
      self.indicator = document.getElementById('indicator');
    });

    insert (event) {
      self.indicator.style.top = event.clientY;
      self.indicator.style.left = event.clientX;
    }

    handler (event) {
      self.direction = event.target.dataset.direction;
      self.update();
    }

    magnify (event) {
      console.log(event.target.value / 100);
    }
  </script>
</cover-image-editor>
