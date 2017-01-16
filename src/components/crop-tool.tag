<crop-tool>
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
      };
      self.dimensions.aspectRatio = self.dimensions.width / self.dimensions.height;
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
        console.log(self.dimensions.aspectRatio);
        if (self.dimensions.aspectRatio > 1) {
          // resize by height
          let rHeight = self.partnerCrops[i].height;
          let rWidth = (self.dimensions.width / self.dimensions.height) * rHeight;
          let cWidth = self.partnerCrops[i].width;
          let cHeight = rHeight;
          let gX = (self.gravity.x / self.dimensions.width) * rWidth;
          let gY = (self.gravity.y / self.dimensions.height) * rHeight;
          let cY = cHeight;
          let cX = gX - (0.5 * cWidth);
          console.log(`rHeight: ${rHeight}, rWidth: ${rWidth}, cWidth: ${cWidth}, cHeight: ${cHeight}, gY: ${gY}, gX: ${gX}, cY: ${cY}, cX: ${cX}`);
        } else {
          // resize by width
          let rWidth = self.partnerCrops[i].width;
          let rHeight = rWidth / (self.dimensions.width / self.dimensions.height);
          let cWidth = rWidth;
          let cHeight = self.partnerCrops[i].height;
          let gX = (self.gravity.x / self.dimensions.width) * rWidth;
          let gY = (self.gravity.y / self.dimensions.height) * rHeight;
          let cY = gY - (0.5 * cHeight);
          let cX = cWidth;
          console.log(`rHeight: ${rHeight}, rWidth: ${rWidth}, cWidth: ${cWidth}, cHeight: ${cHeight}, gY: ${gY}, gX: ${gX}, cY: ${cY}, cX: ${cX}`);
        }
      }
    }
  </script>
</crop-tool>
