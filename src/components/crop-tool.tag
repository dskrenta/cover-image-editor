<crop-tool>
  <div id="container">
    <img id="image" onclick={insert} onload={dimensions} src="http://proxy.topixcdn.com/ipicimg/{id}" />
    <span id="indicator" onclick={insert}>X</span>
  </div>
  <input type="range" value="100" max="500" min="100" onchange={scale}></input>
  <label>{gravity.scale}</label>
  <p></p>
  <virtual each={imgUrl, i in previewCrops}>
    <img src={imgUrl} height="200px"/>
  </virtual>

  <style>
    #container {
      position: relative;
      height: 300px;
    }

    #image {
      position: absolute;
      height: 300px;
    }

    #indicator {
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
    this.id = opts.id;
    this.crops = opts.crops;
    this.gravity = {x: 0, y: 0, scale: 1.0};
    this.previewCrops = [];

    this.on('mount', () => {
      self.indicator = document.getElementById('indicator');
      self.container = document.getElementById('container');
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
      self.gravity.x = event.clientX;
      self.gravity.y = event.clientY;
      const containerPos = getPosition(self.container);
      const indicatorPos = getPosition(self.indicator);

      self.indicator.style.left = self.gravity.x - containerPos.x - (indicatorPos.width / 2);
      self.indicator.style.top = self.gravity.y - containerPos.y - (indicatorPos.height / 2);

      calculateValues();
    }

    scale (event) {
      self.gravity.scale = event.target.value / 100;
      calculateValues();
    }

    function calculateValues () {
      self.previewCrops.splice(0);
      let finalCrops = [];
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

        let cX = Math.round(gX * self.gravity.scale) - (0.5 * cWidth);
        let cY = Math.round(gY * self.gravity.scale) - (0.5 * cHeight);

        resizeWidth = Math.round(resizeWidth * self.gravity.scale);
        resizeHeight = Math.round(resizeHeight * self.gravity.scale);

        if (cX < 0 ) {
          cX = 0;
        } else if (cX > (resizeWidth - cWidth)) {
          cX = Math.round(resizeWidth - cWidth);
        }

        if (cY < 0) {
          cY = 0;
        } else if (cY > (resizeHeight - cHeight)) {
          cY = Math.round(resizeHeight - cHeight);
        }

        largestSize = Math.round(largestSize * self.gravity.scale);

        cWidth += cX;
        cHeight += cY;

        const cropSpec = `${param}${largestSize}-cp${cX}x${cY}x${cWidth}x${cHeight}`;
        const imgUrl = `http:\/\/proxy.topixcdn.com/ipicimg/${self.id}-${cropSpec}`;
        finalCrops.push(cropSpec);
        self.previewCrops.push(imgUrl);
      }
      opts.cb(finalCrops);
    }

    function getPosition (element) {
      const rect = element.getBoundingClientRect();
      return {
        x: rect.left,
        y: rect.top,
        width: rect.width,
        height: rect.height
      };
    }
  </script>
</crop-tool>
