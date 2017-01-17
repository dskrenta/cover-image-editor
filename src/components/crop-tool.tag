<crop-tool>
  <div class="container">
    <img id="image" class="preview" onclick={insert} onload={dimensions} src="http://proxy.topixcdn.com/ipicimg/{id}" />
    <span id="indicator">X</span>
  </div>

  <!--
  <virtual each={partnerCrops}>
    <p>Width: {width}, Height: {height}</p>
  </virtual>
  -->

  <style>
    .container {
      position: relative;
    }

    .preview {
      position: absolute;
      width: 400px;
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
    this.id = 'B5772M9IEU0AA67R';
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
        pWidth: event.path[0].clientWidth,
        pHeight: event.path[0].clientHeight
      };
      self.dimensions.aspectRatio = self.dimensions.width / self.dimensions.height;
      console.log(self.dimensions.width, self.dimensions.height);
    }

    insert (event) {
      self.indicator.style.top = event.clientY;
      self.indicator.style.left = event.clientX;
      self.gravity = {x: event.clientX, y: event.clientY, scale: 1};
      calculateValues();
    }

    function calculateValues () {
      for (let i = 0; i < self.partnerCrops.length; i++) {
        let aspectRatio = self.partnerCrops[i].width / self.partnerCrops[i].height;
        console.log(aspectRatio);
        // if (aspectRatio > 1) {
        if (self.dimensions.aspectRatio > 1) {
          // resize by height
          let cHeight = self.dimensions.height * self.gravity.scale;
          let cWidth = aspectRatio * cHeight * self.gravity.scale;
          let gX = (self.gravity.x / self.dimensions.pWidth) * aspectRatio * cHeight;
          let gY = (self.gravity.y / self.dimensions.pHeight) * aspectRatio * cWidth;
          let cX =  gX - (0.5 * cWidth);
          let cY = gY + (0.5 * cHeight);
          console.log(`gX: ${gX}, gY: ${gY}, cX: ${cX}, cY: ${cY}, cWidth: ${cWidth}, cHeight: ${cHeight}`);
          console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}-cp${cX > 0 ? cX : 0}x${cY}x${cWidth}x${cHeight}`);
        } else {
          // resize by width
          let cWidth = self.dimensions.width * self.gravity.scale;
          let cHeight = (cWidth / aspectRatio) * self.gravity.scale;
          let gX = (self.gravity.x / self.dimensions.pWidth) * aspectRatio * cHeight;
          let gY = (self.gravity.y / self.dimensions.pHeight) * aspectRatio * cWidth;
          let cX =  gX - (0.5 * cWidth);
          let cY = gY + (0.5 * cHeight);
          console.log(`gX: ${gX}, gY: ${gY}, cX: ${cX}, cY: ${cY}, cWidth: ${cWidth}, cHeight: ${cHeight}`);
          console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}-cp${cX > 0 ? cX : 0}x${cY}x${cWidth}x${cHeight}`);
        }
      }
    }

    /*
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
          let cX = Math.floor(gX - (0.5 * cWidth));
          console.log(`rHeight: ${rHeight}, rWidth: ${rWidth}, cWidth: ${cWidth}, cHeight: ${cHeight}, gY: ${gY}, gX: ${gX}, cY: ${cY}, cX: ${cX}`);
          console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}-rszh${rHeight}-cp${cX}x${cY}x${cWidth}x${cHeight}`);
        } else {
          // resize by width
          let rWidth = self.partnerCrops[i].width;
          let rHeight = rWidth / (self.dimensions.width / self.dimensions.height);
          let cWidth = rWidth;
          let cHeight = self.partnerCrops[i].height;
          let gX = (self.gravity.x / self.dimensions.width) * rWidth;
          let gY = (self.gravity.y / self.dimensions.height) * rHeight;
          let cY = Math.floor(gY - (0.5 * cHeight));
          let cX = cWidth;
          console.log(`rHeight: ${rHeight}, rWidth: ${rWidth}, cWidth: ${cWidth}, cHeight: ${cHeight}, gY: ${gY}, gX: ${gX}, cY: ${cY}, cX: ${cX}`);
          console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}-rszw${rWidth}-cp${cX}x${cY}x${cWidth}x${cHeight}`);
        }
      }
    }
    */
  </script>
</crop-tool>
