<crop-tool>
  <div class="container">
    <img id="image" class="preview" onclick={insert} onload={dimensions} src="http://proxy.topixcdn.com/ipicimg/{id}" />
    <span id="indicator">X</span>
  </div>

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
    this.crops = [
      {width: 400, height: 300},
      {width: 300, height: 400},
      {width: 300, height: 300}
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
    }

    insert (event) {
      let x = event.clientX;
      let y = event.clientY;
      self.indicator.style.left = x;
      self.indicator.style.top = y;
      self.gravity = {x: x, y: y, scale: 1.0};
      calculateValues();
    }

    function calculateValues () {
      for (let i = 0; i < self.crops.length; i++) {
        const aspectRatio = self.crops[i].width / self.crops[i].height;
        let largestSize = aspectRatio > 1 ? self.crops[i].width : self.crops[i].height;
        let cWidth = self.crops[i].width;
        let cHeight = self.crops[i].height;
        let resizeWidth = 0;
        let resizeHeight = 0;
        let param = '';

        if (self.dimensions.aspectRatio > 1) {
          resizeHeight = largestSize;
          resizeWidth = self.dimensions.aspectRatio * resizeHeight;
          param = 'rszh';
        } else {
          resizeWidth = largestSize;
          resizeHeight = resizeWidth / self.dimensions.aspectRatio;
          param = 'rszw';
        }

        let gX = Math.round((self.gravity.x / self.dimensions.pWidth) * resizeWidth);
        let gY = Math.round((self.gravity.y / self.dimensions.pHeight) * resizeHeight);

        let cX = gX - (0.5 * cWidth);
        let cY = gY - (0.5 * cHeight);

        if (cX < 0 ) {
          cX = 0;
        } else if (cX > (resizeWidth - cWidth)) {
          cX = Math.round(resizeWidth - cWidth);
        }

        if (cY < 0) {
          cY = 0;
        } else if (cY > (resizeHeight - cHeight)) {
          cY = resizeHeight - cHeight;
        }

        cX = Math.round(cX * self.gravity.scale);
        cY = Math.round(cY * self.gravity.scale);
        largestSize = Math.round(largestSize * self.gravity.scale);

        cWidth += cX;
        cHeight += cY;

        console.log(resizeWidth, resizeHeight);
        console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}-${param}${largestSize}-cp${cX}x${cY}x${cWidth}x${cHeight}`);
      }
    }
  </script>
</crop-tool>
