define(["../../init/AppService"], function(services) {
  services.factory("ProjectDataService", ProjectDataService);

  ProjectDataService.$inject = ["$http", "$q"];

  function ProjectDataService($http, $q) {

    var service = {
      openProject: openProject,
      getProjects: getProjects,
      createProject: createProject,
      deleteProject: deleteProject,

      getProjectResources: getProjectResources,
      createProjectResource: createProjectResource,
      deleteProjectResource: deleteProjectResource
    }

    return service;

    function openProject(params) {
      var projectName = params.projectName;
      var url = "./rest/project/" + projectName + "/open";
      return $http.get(url).then(httpCallSuccess).catch(httpCallFailure);
    }

    function getProjects() {
      var url = "./rest/project";
      return $http.get(url).then(httpCallSuccess).catch(httpCallFailure);
    }

    function createProject(params) {
      var project = params.project;
      var url = "./rest/project";
      return $http.post(url, project).then(httpCallSuccess).catch(httpCallFailure);
    }

    function deleteProject(params) {
      var projectName = params.projectName;
      var url = "./rest/project/" + projectName;
      return $http.delete(url).then(httpCallSuccess).catch(httpCallFailure);
    }

    function getProjectResources(params) {
      var projectName = params.projectName;
      var url = "./rest/project/" + projectName + "/resources";
      return $http.get(url).then(httpCallSuccess).catch(httpCallFailure);
    }

    function createProjectResource(params) {
      var projectName = params.projectName;
      var resource = params.resource;
      var url = "./rest/project/" + projectName + "/resources";
      return $http.post(url, resource).then(httpCallSuccess).catch(httpCallFailure);
    }

    function deleteProjectResource(params) {
      var projectName = params.projectName;
      var resourceId = params.resourceId;
      var url = "./rest/project/" + projectName + "/" + resourceId;
      return $http.delete(url).then(httpCallSuccess).catch(httpCallFailure);
    }

    function httpCallSuccess(response) {
      return response.data;
    }

    function httpCallFailure(error){
      return $q.reject(error)
    }
  }
});
