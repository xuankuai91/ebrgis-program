require([
    "esri/Map",
    "esri/views/MapView",
    "esri/layers/FeatureLayer",
    "esri/layers/GroupLayer",
    "esri/widgets/LayerList",
    "dojo/domReady!"
  ],
  function(
    Map, MapView, FeatureLayer, GroupLayer, LayerList
  ) {
    var map = new Map({
      basemap: "topo"
    });

    var view = new MapView({
      center: [-91.05, 30.5161109],
      zoom: 11,
      container: "viewDiv",
      map: map,
    });

    // Define popup template and get feature layers
    var census2010Template = {
      title: "Census 2010",
      content: [{
        type: "fields",
        fieldInfos: [{
          fieldName: "TRACT",
          label: "Tract",
          visible: true
        }, {
          fieldName: "SUM_TOTAL_POPULATION",
          label: "Population",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }, {
          fieldName: "DETAIL_URL",
          label: "More Details",
          visible: true
        }]
      }]
    };

    var census2010Layer = new FeatureLayer({
      url: "https://services.arcgis.com/KYvXadMcgf0K1EzK/ArcGIS/rest/services/Census_2010_Tract/FeatureServer/0",
      outFields: ["*"],
      popupTemplate: census2010Template
    });

    census2010Layer.title = "Census 2010";

    var census2000Template = {
      title: "Census 2000",
      content: [{
        type: "fields",
        fieldInfos: [{
          fieldName: "TRACT",
          label: "Tract",
          visible: true
        }, {
          fieldName: "POPULATION",
          label: "Population",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }, {
          fieldName: "DETAIL_URL",
          label: "More Details",
          visible: true
        }]
      }]
    };

    var census2000Layer = new FeatureLayer({
      url: "http://services.arcgis.com/KYvXadMcgf0K1EzK/ArcGIS/rest/services/Census_2000/FeatureServer/0",
      outFields: ["*"],
      popupTemplate: census2000Template
    });

    census2000Layer.title = "Census 2000";

    var census1990Template = {
      title: "Census 1990",
      content: [{
        type: "fields",
        fieldInfos: [{
          fieldName: "TRACT",
          label: "Tract",
          visible: true
        }, {
          fieldName: "POPULATION",
          label: "Population",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }]
      }]
    };

    var census1990Layer = new FeatureLayer({
      url: "https://services.arcgis.com/KYvXadMcgf0K1EzK/ArcGIS/rest/services/Census_1990/FeatureServer/0",
      outFields: ["*"],
      popupTemplate: census1990Template
    });

    var census1980Template = {
      title: "Census 1980",
      content: [{
        type: "fields",
        fieldInfos: [{
          fieldName: "TRACT",
          label: "Tract",
          visible: true
        }, {
          fieldName: "POPULATION",
          label: "Population",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }]
      }]
    };

    var census1980Layer = new FeatureLayer({
      url: "https://services.arcgis.com/KYvXadMcgf0K1EzK/arcgis/rest/services/Census_1980/FeatureServer/0",
      outFields: ["*"],
      popupTemplate: census1980Template
    });

    var census1970Template = {
      title: "Census 1970",
      content: [{
        type: "fields",
        fieldInfos: [{
          fieldName: "TRACT",
          label: "Tract",
          visible: true
        }, {
          fieldName: "POPULATION",
          label: "Population",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }]
      }]
    };

    var census1970Layer = new FeatureLayer({
      url: "https://services.arcgis.com/KYvXadMcgf0K1EzK/arcgis/rest/services/Census_1970/FeatureServer/0",
      outFields: ["*"],
      popupTemplate: census1970Template
    });

    var census1960Template = {
      title: "Census 1960",
      content: [{
        type: "fields",
        fieldInfos: [{
          fieldName: "TRACT",
          label: "Tract",
          visible: true
        }, {
          fieldName: "POPULATION",
          label: "Population",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }]
      }]
    };

    var census1960Layer = new FeatureLayer({
      url: "https://services.arcgis.com/KYvXadMcgf0K1EzK/arcgis/rest/services/Census_1960/FeatureServer/0",
      outFields: ["*"],
      popupTemplate: census1960Template
    });

    var census1950Template = {
      title: "Census 1950",
      content: [{
        type: "fields",
        fieldInfos: [{
          fieldName: "WARD_NUM",
          label: "Ward Number",
          visible: true
        }, {
          fieldName: "POPULATION",
          label: "Population",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }]
      }]
    };

    var census1950Layer = new FeatureLayer({
      url: "http://services.arcgis.com/KYvXadMcgf0K1EzK/arcgis/rest/services/Wards_1950/FeatureServer/0",
      outFields: ["*"],
      popupTemplate: census1950Template
    });

    census1950Layer.title = "Census 1950";

    var censusPre1950Template = {
      title: "Census 1940-1890",
      content: [{
        type: "fields",
        fieldInfos: [{
          fieldName: "WARD_NUM",
          label: "Ward Number",
          visible: true
        }, {
          fieldName: "POPL_1940",
          label: "Population 1940",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }, {
          fieldName: "POPL_1930",
          label: "Population 1930",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }, {
          fieldName: "POPL_1920",
          label: "Population 1920",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }, {
          fieldName: "POPL_1910",
          label: "Population 1910",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }, {
          fieldName: "POPL_1900",
          label: "Population 1900",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }, {
          fieldName: "POPL_1890",
          label: "Population 1890",
          visible: true,
          format: {
            digitSeparator: true,
            places: 0
          }
        }]
      }]
    };

    var censusPre1950Layer = new FeatureLayer({
      url: "http://services.arcgis.com/KYvXadMcgf0K1EzK/arcgis/rest/services/EBRP_Wards_Pre1949/FeatureServer/0",
      outFields: ["*"],
      popupTemplate: censusPre1950Template
    });

    censusPre1950Layer.title = "Census 1940-1890";

    // Add feature layers to a group layer
    var censusGroupLayer = new GroupLayer({
      title: "Census",
      visible: true,
      visibilityMode: "exclusive",
      layers: [censusPre1950Layer, census1950Layer, census1960Layer, census1970Layer, census1980Layer, census1990Layer, census2000Layer, census2010Layer]
    });

    map.add(censusGroupLayer);

    // Create layer list widget
    view.when(function() {
      var layerList = new LayerList({
        view: view
      });

      // Add widget to the top right corner of the view
      view.ui.add(layerList, "top-right");
    });
  });
