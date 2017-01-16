<cover-image-editor>
  <div class="container">
    <img id="image" class="preview" onclick={insert} onload={dimensions} src="http://proxy.topixcdn.com/ipicimg/{id}-rszw400" />
    <span id="indicator">X</span>
  </div>
  <virtual each={partnerCrops}>
    <p>Width: {width}, Height: {height}</p>
  </virtual>

  <style>
    .container {
      position: relative;
    }

    .preview {
      position: absolute;
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
    this.id = 'G9F43EV646AG1CBP';
    this.partnerCrops = [
      {width: 500, height: 500},
      {width: 400, height: 500},
      {width: 500, height: 700}
    ];

    this.on('mount', () => {
      self.indicator = document.getElementById('indicator');
    });

    dimensions (event) {
      self.dimensions = {
        width: event.path[0].naturalWidth,
        height: event.path[0].naturalHeight,
        aspectRatio: this.width / this.height
      };
      // self.aspectRatio = dimensions.width / dimensions.height;
    }

    /*
    dimensions (event) {
      const dimensions = {width: event.path[0].naturalWidth, height: event.path[0].naturalHeight};
      const aspectRatio = dimensions.width / dimensions.height;
      let resizeParam = '';
      let resizeKey = '';

      if (aspectRatio > 1) {
        // resize by height
        resizeParam = 'rszh';
        resizeKey = 'height';
      } else {
        // resize by width
        resizeParam = 'rszw';
        resizeKey = 'width';
      }

      for (let i = 0; i < self.partnerCrops.length; i++) {
        let resize = dimensions[resizeKey];
        let resizeWidth = resizeKey === 'width' ? self.partnerCrops.width : (dimensions.width / dimensions.height) * self.partnerCrops.height;
        let resizeHeight = resizeKey === 'height' ? self.partnerCrops.height : self.partnerCrops.width / (dimensions.width / dimensions.height);
      }
    }
    */

    insert (event) {
      self.indicator.style.top = event.clientY;
      self.indicator.style.left = event.clientX;
      self.gravity = {x: event.clientX, y: event.clientY};
      calculateValues();
    }

    /*
      solve for cX, cY, cWidth, cHeight
    */

    function calculateValues () {
      for (let i = 0; i < self.partnerCrops.length; i++) {
        if (self.aspectRatio > 1) {
          // resize by height
          let resizeHeight = self.partnerCrops[i].height;
          let resizeWidth = (self.dimensions.width / self.dimensions.height) * resizeHeight;
          let cWidth = self.partnerCrops[i].width;
          let cHeight = resizeHeight;
          let cY = resizeHeight;
          let cX = // ?
        } else {
          // resize by width
        }
      }
    }
  </script>
</cover-image-editor>
