import axios from 'axios';
// axios.interceptors.request.use(function(config) {
//   const token = cookie.get(__TOKEN_KEY__);

//   if ( token != null ) {
//     config.headers.Authorization = `Bearer ${token}`;
//   }

//   return config;
// }, function(err) {
//   return Promise.reject(err);
// });
const setToken = (params) => {
  const tags = document.getElementsByTagName("meta");
  for (let i = 0; i < tags.length; i++) {
    if (tags[i].name === 'csrf-token') {
      params.authenticity_token = tags[i].content;
      break;
    }
  }
  return params;
};

export default {
  get: (path, params = {}) => {
    return axios.get(path, params);
  },
  post: (path, params = {}) => {
    let headers = new Headers();

    headers.append('Content-Type', 'application/json');
    headers.append('Accept', 'application/json');
    return axios.post(path, setToken(params));
  },
  put: (path, params = {}) => {
    return axios.post(path, setToken(params));
  },
  delete: (path, params = {}) => {
    return axios.delete(path, setToken(params));
  }
}
