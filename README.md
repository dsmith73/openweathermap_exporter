# Openweather exporter for prometheus  
_docker image_  


Exporter for openweather API  
_modified the `.go` from: [blackrez/openweathermap_exporter](https://github.com/blackrez/openweathermap_exporter) to provide additional options and information_  

This leverages the code from [Brian Downs](https://github.com/briandowns/openweathermap)  

---

## Quickstart  

**Create an API key from https://openweathermap.org/.**  

This exporter leverages city_id from openweathermap.org for better accuracy -  
The IDs can be found **[here](http://bulk.openweathermap.org/sample/)**  

`.env`
```sh

OWM_PORT=:2112
OWM_API_KEY=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
OWM_LOCATION=4259418

```

**Clone this repo**  

**Add the scraper in prometheus**  

```yml

scrape_configs:
  - job_name: 'weather'
    scrape_interval: 60s
    # Port is configurable
    static_configs:
      - targets: ['openweathermap:2112']
      
```

**Spin up the docker image**  
`docker build . -t openweathermap_exporter --force-rm`  
  * `--force-rm` tells docker to get rid of intermediate builds in the multi-stage build process  

---

## or - Spin up with Docker-Compose

```yml

  openweathermap:
    build:
      context: https://github.com/dsmith73/openweathermap_exporter.git
      dockerfile: ./Dockerfile
    container_name: openweathermap
    hostname: openweathermap
    environment:   
      - OWM_PORT=${OWM_PORT}
      - OWM_API_KEY=${OWM_API_KEY}
      - OWM_LOCATION=${OWM_LOCATION}
    expose:
      - 2112
    restart: always
    labels:
      description: "container to pull weather info for specified locations"
      
```

