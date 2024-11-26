
sugarcane_url=${1}
pineapple_url=${2}

dataset_dir="datasets"

download_dataset() {
    download_dataset_dir="${dataset_dir}/${1}"
    if [ -d ${download_dataset_dir} ]; then
        echo "${1} dataset already exists."
        read -p "Do you want to remove it? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf ${download_dataset_dir}
        else
            exit 0
        fi
    fi
    mkdir -p ${download_dataset_dir}
    echo "Downloading ${1} dataset..."
    curl -L ${2} > roboflow.zip; unzip roboflow.zip -d ${download_dataset_dir}; rm roboflow.zip

    # data.yamlを書き換える
    sed -i -e "s/\.\.\//${download_dataset_dir}\//g" ${download_dataset_dir}/data.yaml

    echo "${1} dataset downloaded."
}
# Download sugarcane dataset
download_dataset "sugarcane" ${sugarcane_url}

# Download pineapple dataset
download_dataset "pineapple" ${pineapple_url}
