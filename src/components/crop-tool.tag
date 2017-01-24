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
      {width: 200, height: 200},
      {width: 200, height: 300},
      {width: 300, height: 200}
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
      self.gravity = {x: x, y: y};
      calculateValues();
    }

    function calculateValues () {
      for (let i = 0; i < self.crops.length; i++) {
        let aspectRatio = self.crops[i].width / self.crops[i].height;
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

        let gX = (self.gravity.x / self.dimensions.pWidth) * resizeWidth;
        let gY = (self.gravity.y / self.dimensions.pHeight) * resizeHeight;

        /*
        let gXMin = 0.5 * cWidth;
        let gXMax = resizeWidth - gXMin;
        let gYMin = 0.5 * cHeight;
        let gYMax = resizeHeight - gYMin;

        if (gX > gXMax) gX = gXMax;
        else if (gX < gXMin) gX = gXMin;
        if (gY > gYMax) gY = gYMax;
        else if (gY < gYMin) gY = gYMin;
        */

        let cX = gX - (0.5 * cWidth);
        let cY = gY - (0.5 * cHeight);

        let cXMin = 0;
        let cXMax = resizeWidth - cWidth;
        let cYMin = 0;
        let cYMax = resizeHeight - cHeight;

        if (cX < cXMin) cX = cXMin;
        if (cX > cXMax) cX = cXMax;
        if (cY < cYMin) cY = cYMin;
        if (cY > cYMax) cY = cYMax;

        let calculatedFinalWidth = cX + cWidth;
        let calculatedFinalHeight = cY + cHeight;

        /*
        let cX = gX - (0.5 * self.crops[i].width);
        let cY = gY - (0.5 * self.crops[i].height);

        if (cX < 0) cX = 0;
        if (cY < 0) cY = 0;

        let calculatedFinalWidth = cX + self.crops[i].width;
        let calculatedFinalHeight = cY + self.crops[i].height;

        if (calculatedFinalWidth > resizeWidth) cX = resizeWidth - self.crops[i].width;
        if (calculatedFinalHeight > resizeHeight) cY = resizeHeight - self.crops[i].height;
        */

        if (calculatedFinalWidth > cWidth) cX = cX = (calculatedFinalWidth - cWidth);
        if (calculatedFinalHeight > cHeight) cY = cY = (calculatedFinalHeight - cHeight);

        if (calculatedFinalWidth > cWidth) console.log('calc width over max');
        if (calculatedFinalHeight > cHeight) console.log('calc height over max');

        // console.log(`Needed: ${self.crops[i].width} ${self.crops[i].height}, Actual: ${resizeWidth} ${resizeHeight}`);
        // console.log(resizeWidth, resizeHeight);
        // console.log(cWidth, cHeight);
        console.log(calculatedFinalWidth, cWidth, calculatedFinalHeight, cHeight);
        console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}-${param}${largestSize}-cp${cX}x${cY}x${cWidth}x${cHeight}`);
      }
    }

    /*
    function calculateValues () {
      for (let i = 0; i < self.partnerCrops.length; i++) {
        if (self.dimensions.aspectRatio > 1) {
          // width is larger, resize by height
          let resizeHeight = self.partnerCrops[i].height;
          let resizeWidth = self.dimensions.aspectRatio * resizeHeight;
          let cHeight = self.partnerCrops[i].height;
          let cWidth = self.partnerCrops[i].width;
          let gX = (self.gravity.x / self.dimensions.pWidth) * resizeWidth;
          let gY = (self.gravity.y / self.dimensions.pHeight) * resizeHeight;
          let cX =  gX - (0.5 * cWidth);
          cX = cX > 0 ? cX : 0;

          let calculatedCropWidth = cX + cWidth;
          console.log(`calculatedWidthCOG: ${calculatedCropWidth}, resizeWidth: ${resizeWidth}, cWidth: ${cWidth}`);
          if (calculatedCropWidth > resizeWidth) {
            console.log('triggered');
            cX = resizeWidth - cWidth;
          }


          // let cY = cHeight - (gY + (0.5 * cHeight));
          let cY = 0;
          console.log(`x: ${gX}, y: ${gY}, cX: ${cX}, cY: ${cY}, cWidth: ${cWidth}, cHeight: ${cHeight}`);
          console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}-rszh${resizeHeight}-cp${cX}x${cY}x${cWidth}x${cHeight}`);
          // convert x,y to new image size using cWidth and cHeight
          // calculate cX and cY from x and y
          console.log(cWidth, cHeight);
        } else {
          // height is larger, resize by width
          let cWidth = self.partnerCrops[i].width;
          let cHeight = cWidth / self.dimensions.aspectRatio;
        }
      }
    }
    */

    /*
    function calculateValues () {
      for (let i = 0; i < self.partnerCrops.length; i++) {
        let aspectRatio = self.partnerCrops[i].width / self.partnerCrops[i].height;
        let largestLength = self.dimensions.aspectRatio > 1 ? self.dimensions.height : self.dimensions.width;
        let cWidth = 0;
        let cHeight = 0;
        if (aspectRatio > 1) {
          cWidth = largestLength;
          cHeight = cWidth / aspectRatio;
        } else {
          cHeight = largestLength;
          cWidth = aspectRatio * cHeight;
        }
        let cX =  self.gravity.x - (0.5 * cWidth);
        let cY = self.dimensions.height - (self.gravity.y + (0.5 * cHeight));
        const cropSpec = `-cp${Math.floor(cX)}x${Math.floor(cY)}x${Math.floor(cWidth)}x${Math.floor(cHeight)}`;
        console.log(`x: ${self.gravity.x}, y: ${self.gravity.y}, cX: ${cX}, cY: ${cY}, cWidth: ${cWidth}, cHeight: ${cHeight}`);
        console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}${cropSpec}-fill${self.partnerCrops[i].width}x${self.partnerCrops[i].height}x`);
      }
    }
    */

    /*
    function calculateValues () {
      for (let i = 0; i < self.partnerCrops.length; i++) {
        let aspectRatio = self.partnerCrops[i].width / self.partnerCrops[i].height;
        let cWidth = 0;
        let cHeight = 0;
        if (self.dimensions.aspectRatio > 1) {
          // resize by height
          cHeight = self.dimensions.height;
          cWidth = aspectRatio * cHeight;
        } else {
          // resize by width
          cWidth = self.dimensions.width;
          cHeight = cWidth / aspectRatio;
        }
        let cX =  self.gravity.x - (0.5 * cWidth);
        let cY = self.gravity.y + (0.5 * cHeight);
        const cropSpec = `-cp${Math.floor(cX)}x${Math.floor(cY)}x${Math.floor(cWidth)}x${Math.floor(cHeight)}`;
        console.log(`cX: ${cX}, cY: ${cY}, cWidth: ${cWidth}, cHeight: ${cHeight}`);
        console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}${cropSpec}`);
      }
    }
    */

    /*
    function calculateValues () {
      for (let i = 0; i < self.partnerCrops.length; i++) {
        let aspectRatio = self.partnerCrops[i].width / self.partnerCrops[i].height;
        console.log(aspectRatio);
        // if (aspectRatio > 1) {
        if (self.dimensions.aspectRatio > 1) {
          // resize by height
          let cHeight = self.dimensions.height * self.gravity.scale;
          let cWidth = self.dimensions.aspectRatio * cHeight * self.gravity.scale;
          let gX = (self.gravity.x / self.dimensions.pWidth) * self.dimensions.aspectRatio * cHeight;
          let gY = (self.gravity.y / self.dimensions.pHeight) * self.dimensions.aspectRatio * cWidth;
          let cX =  gX - (0.5 * cWidth);
          let cY = gY + (0.5 * cHeight);
          console.log(`gX: ${gX}, gY: ${gY}, cX: ${cX}, cY: ${cY}, cWidth: ${cWidth}, cHeight: ${cHeight}`);
          console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}-cp${cX > 0 ? cX : 0}x${cY}x${cWidth}x${cHeight}`);
        } else {
          // resize by width
          let cWidth = self.dimensions.width * self.gravity.scale;
          let cHeight = (cWidth / self.dimensions.aspectRatio) * self.gravity.scale;
          let gX = (self.gravity.x / self.dimensions.pWidth) * self.dimensions.aspectRatio * cHeight;
          let gY = (self.gravity.y / self.dimensions.pHeight) * self.dimensions.aspectRatio * cWidth;
          let cX =  gX - (0.5 * cWidth);
          let cY = gY + (0.5 * cHeight);
          console.log(`gX: ${gX}, gY: ${gY}, cX: ${cX}, cY: ${cY}, cWidth: ${cWidth}, cHeight: ${cHeight}`);
          console.log(`http:\/\/proxy.topixcdn.com/ipicimg/${self.id}-cp${cX > 0 ? cX : 0}x${cY}x${cWidth}x${cHeight}`);
        }
      }
    }
    */

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
