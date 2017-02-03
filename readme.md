# crop-tool
crop-tool component

## Install
```
git clone https://github.com/dskrenta/crop-tool
cd crop-tool && npm install
```

## Run & Build
```
npm run build
npm start
```

## Component Usage

```
riot.mount('crop-tool', {
  id: '90B8I2T6H2N62BD3',
  crops: [
    {width: 400, height: 300},
    {width: 300, height: 400},
    {width: 300, height: 300}
  ],
  cb: (result) => console.log(result),
  dev: true
});
```
When mounting the tag an image id, array of crops, callback function, and a dev flag must be passed. Default dev is false.
