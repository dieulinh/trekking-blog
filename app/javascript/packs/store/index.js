import Vue from 'vue';
import Vuex from 'vuex';
import * as types from './mutation-types';
import axios from 'axios';

Vue.use(Vuex);
const debug = process.env.NODE_ENV !== 'production';
const API_URL = process.env.ROOT_API;

const mutations = {
  categoryPost(state, category) {
    this.state.category = category;
  },
  searchTerm(state, term) {
    this.state.searchTerm = term;
  },
  currentNews(state, payload) {
    state.current_news = payload;
  },
  setNews(state, payload) {
    state.news = payload;
  },
  setPosts(state, payload) {
    state.posts = payload.posts;
  },
  setPostPage(state, page) {
    state.current_post_page = page;
  },
  setTotalPage(state, payload) {
    state.total_pages = payload.total_pages;
  },
  logout(state) {
    state.authenticated = false;
  },
  login(state, value) {
    state.auth_token = value;
    state.authenticated = true;
  },
  auth_token(state, value) {
    state.auth_token = value;
  },
  auth(state, value) {
    state.auth = value;
  },
  getErrors(state, value) {
    state.errors = value
  },
  showLogin(state, value) {
    state.showLogin = value;
  },
  showRegisterForm(state, visible) {
    state.showRegisterForm = visible;
  },
  registerUser(state, user) {
    state.user = user
  }
};

const actions = {
  searchTerm({commit}, term){
    commit('searchTerm', term);
  },
  clearCurrentNews({commit}) {
    commit("currentNews", null);
  },
  async getPostDetail({commit}, postDetailsParams) {
    try {
      let response = await axios.get(`${process.env.ROOT_API}/posts/details?news_url=${postDetailsParams["postUrl"]}`)
      // console.log(response.data);
      console.log(response);
      commit("currentNews", response.data);
    } catch (exception) {
      console.error(exception);
    }
  },
  async getNews({commit}) {
    try {
      let response = await axios.get(`${process.env.ROOT_API}/posts/news`)
      commit('setPosts', response.data);
      commit('setNews', true);
      commit('setPostPage', 1);
      commit('setTotalPage', 1);
    } catch (exception) {
      console.error(exception)
    }
  },
  async getPosts({commit}, postParams) {
    try {
      let searchParams = `${process.env.ROOT_API}/posts?page=${postParams.page+1}`;
      if (postParams.terms) {
        searchParams = `${searchParams}&terms=${postParams.terms}`;
      }
      console.log(postParams);
      if (postParams.category) {
        console.log(postParams.category)
        searchParams = `${searchParams}&category=${postParams.category}`;
      }
      let response = await axios.get(searchParams);
        if (postParams.terms) commit('searchTerm',postParams.terms);
        commit('setPosts', response.data);
        commit('setPostPage', +postParams.page);
        commit('setTotalPage', response.data);
        commit('setNews', false);
    } catch (error) {
      commit('setPosts', []);
    }
  },
  setError({commit}, errors) {
    commit('getErrors', errors);
  },
  logout({commit}) {
    localStorage.removeItem('auth_token');
    commit('logout');
  },
  showRegisterForm({commit}, showRegister) {
    commit('showRegisterForm', showRegister);
  },
  showLogin({commit}, showValue) {
    commit('showLogin', showValue);
  },
  async createUser({commit}, user) {
    try {
      let response = await axios.post(`${process.env.ROOT_API}/login/register`, user );
      if (response.status === 201)
      {
        commit('registerUser', response.data)
      } else {
        console.log(response);
        commit('getErrors', response.data);
      }
    } catch(error) {
      console.log(error);
      commit('getErrors', error);
    }
  },
  async authenticate({commit}, auth_token) {
    commit('auth', auth_token);
  },
  async login({commit}, user) {
    try {
      let response = await axios.post(`${API_URL}/login`, user);
      if (response.status === 201)
      {
        commit('login', response.data);
        commit('auth_token', response.data);
        localStorage.setItem('auth_token', response.data);
      } else {
        commit('getErrors', response.data);
      }
    } catch(error)
    {
      console.log(error.response);
      commit('getErrors', error.response.data);
    }
  }
};

const getters = {
  posts: state => state.posts,
  total_pages: state => state.total_pages,
  user: state => state.user,
  auth_token: state => state.auth_token,
  authenticated: state => state.authenticated,
  errors: state => state.errors,
  showLogin: state => state.showLogin,
  current_post_page: state => state.current_post_page,
  showRegisterForm: state => state.showRegisterForm,
  news: state => state.news,
  current_news: state => state.current_news,
  searchTerm: state => state.searchTerm
};

const state = {
  current_news: null,
  searchTerm: null,
  posts: [],
  current_post_page: 0,
  total_pages: 0,
  accessToken: '',
  posts: [],
  showLogin: false,
  showRegisterForm: false,
  added: [],
  news: true,
  all: [],
  user: null,
  auth: {},
  errors: null,
  auth_token: null,
  authenticated: !!localStorage.getItem('auth_token'),
  postsApiUrl: `${process.env.ROOT_API}/api/v1/posts`
};

export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
});
