package org.telscenter.sail.webapp.presentation.web.controllers.teacher.project;

import java.io.File;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.sail.webapp.dao.ObjectNotFoundException;
import net.sf.sail.webapp.domain.impl.CurnitGetCurnitUrlVisitor;

import org.apache.commons.io.FileUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.telscenter.sail.webapp.domain.project.Project;
import org.telscenter.sail.webapp.presentation.util.json.JSONArray;
import org.telscenter.sail.webapp.presentation.util.json.JSONException;
import org.telscenter.sail.webapp.presentation.util.json.JSONObject;
import org.telscenter.sail.webapp.service.project.ProjectService;

public class AnalyzeProjectController extends AbstractController {

	private ProjectService projectService;
	private Properties portalProperties;

	private HashMap<String, JSONObject> nodeIdToNodeContent = new HashMap<String, JSONObject>();

	private HashMap<String, JSONObject> nodeIdToNode = new HashMap<String, JSONObject>();

	private HashMap<String, String> nodeIdToNodeTitlesWithPosition = new HashMap<String, String>();
	
	private String projectFileLocalPath = "";
	private String projectFolderLocalPath = "";
	private String projectFileWebPath = "";
	private String projectFolderWebPath = "";

	/**
	 * clear the variables
	 */
	private void clearVariables() {
		nodeIdToNodeContent = new HashMap<String, JSONObject>();
		nodeIdToNode = new HashMap<String, JSONObject>();
		nodeIdToNodeTitlesWithPosition = new HashMap<String, String>();
		
		projectFileLocalPath = "";
		projectFolderLocalPath = "";
		projectFileWebPath = "";
		projectFolderWebPath = "";
	}
	
	/**
	 * Handle requests to this controller
	 * @see org.springframework.web.servlet.mvc.AbstractController#handleRequestInternal(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String results = "";

		//get the analyze type e.g. "findBrokenLinks" or "findUnusedAssets"
		String analyzeType = request.getParameter("analyzeType");
		
		if(analyzeType == null) {
			//there was no analyzeType passed in so we will do nothing
		} else if(analyzeType.equals("findBrokenLinks")) {
			//find the broken links in the project
			results = findBrokenLinks(request, response);
		} else if(analyzeType.equals("findUnusedAssets")) {
			//find the unused assets in the project
		}
		
		try {
			//write the results to the response
			response.getWriter().write(results);
		} catch (IOException e) {
			e.printStackTrace();
		}

		clearVariables();
		
		return null;
	}

	/**
	 * Find the broken links in the project or projects. Multiple projects
	 * can be requested at the same time.
	 * @param request
	 * @param response
	 * @return a JSONArray string containing the results
	 */
	private String findBrokenLinks(HttpServletRequest request, HttpServletResponse response) {
		//the string we will return
		String results = "";
		
		//get whether to return the results as html
		String html = request.getParameter("html");
		
		//the JSONArray that will contain all the project results
		JSONArray projectResultsJSONArray = new JSONArray();
		
		//get the project ids we want to find broken links for
		String projectIds = request.getParameter("projectIds");
		
		//get the project id we want to find broken links for
		String projectId = request.getParameter("projectId");

		if(projectIds != null) {
			try {
				//create an array from the project ids
				JSONArray projectIdsArray = new JSONArray(projectIds);

				if(projectIdsArray != null) {
					//loop through all the project ids
					for(int x=0; x<projectIdsArray.length(); x++) {
						//get a project id
						String projectIdStr = projectIdsArray.getString(x);
						Long projectIdLong = Long.parseLong(projectIdStr);

						//find the broken links for the project id
						JSONObject projectResults = findBrokenLinksForProject(projectIdLong);
						
						//put the project results into the array
						projectResultsJSONArray.put(projectResults);
					}
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}
		} else if(projectId != null) {
			//find the broken links for the project id
			JSONObject projectResults = findBrokenLinksForProject(Long.parseLong(projectId));
			
			//put the project results into the array
			projectResultsJSONArray.put(projectResults);
		}
		
		try {
			if(html != null && html.equals("true")) {
				//get the html representation of the JSONArray
				results = getHtmlView(projectResultsJSONArray);
			} else {
				//get the string representation of the JSONArray
				results = projectResultsJSONArray.toString(3);				
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return results;
	}

	/**
	 * Find the broken links for the project
	 * @param projectId the project id
	 * @return a JSONObject that contains the title, project id, and an
	 * array of steps that have broken links as well as the links that
	 * are broken
	 */
	private JSONObject findBrokenLinksForProject(Long projectId) {
		//the object that will contain all the results
		JSONObject resultsJSON = new JSONObject();
		
		try {
			//get the project
			Project project = projectService.getById(projectId);

			//get the project name
			String projectName = project.getName();

			/*
			 * obtain the local path to the project file on the server 
			 * e.g. /Users/geoffreykwan/dev/apache-tomcat-7.0.27/webapps/curriculum/667/wise4.project.json  
			 */
			projectFileLocalPath = getProjectFileLocalPath(project);
			
			/*
			 * obtain the local path to the project folder on the server 
			 * e.g. /Users/geoffreykwan/dev/apache-tomcat-7.0.27/webapps/curriculum/667 
			 */
			projectFolderLocalPath = getProjectFolderLocalPath(project);
			
			/*
			 * obtain the web path to the project file on the server 
			 * e.g. http://wise4.berkeley.edu/curriculum/667/wise4.project.json  
			 */
			projectFileWebPath = getProjectFileWebPath(project);
			
			/*
			 * obtain the web path to the project folder on the server 
			 * e.g. http://wise4.berkeley.edu/curriculum/667  
			 */
			projectFolderWebPath = getProjectFolderWebPath(project);

			//get the project file
			File projectFile = new File(projectFileLocalPath);

			try {
				//get the contents of the project file
				String projectFileString = FileUtils.readFileToString(projectFile);

				//get the JSONObject representation of the project 
				JSONObject projectJSON = new JSONObject(projectFileString);

				/*
				 * parse the project to populate our hashmaps that contain mappings
				 * from node id to node content and node id to node titles
				 */
				parseProject(projectJSON);
				
				//put the project name and id into the results
				resultsJSON.put("projectName", projectName);
				resultsJSON.put("projectId", projectId);
				
				//traverse through the project and analyze each step to search for broken links
				JSONArray stepResults = traverseProject(projectJSON);
				
				//put the step results into the results
				resultsJSON.put("steps", stepResults);
			} catch (IOException e) {
				e.printStackTrace();
			} catch (JSONException e) {
				e.printStackTrace();
			}

		} catch (ObjectNotFoundException e) {
			e.printStackTrace();
		}

		return resultsJSON;
	}

	/**
	 * Parse the project to populate our hashmaps that contain mappings
	 * from node id to node content and node id to node titles
	 * @param projectJSON the project JSON
	 */
	private void parseProject(JSONObject projectJSON) {

		try {
			//get the nodes (aka steps) in the project
			JSONArray nodes = projectJSON.getJSONArray("nodes");

			//loop through all the nodes (aka steps) in the project
			for(int x=0; x<nodes.length(); x++) {
				//get a node
				JSONObject node = nodes.getJSONObject(x);
				if(node != null) {
					//get the node id
					String nodeId = node.getString("identifier");
					
					//get the step file name
					String ref = node.getString("ref");
					
					//get a handle to the file
					File file = new File(projectFolderLocalPath + "/" + ref);
					
					try {
						//get the contents of the file
						String fileContent = FileUtils.readFileToString(file);
						
						//create a JSONObject from the contents
						JSONObject nodeJSON = new JSONObject(fileContent);
						
						//put the contents into our hashmap
						nodeIdToNodeContent.put(nodeId, nodeJSON);
					} catch (IOException e) {
						e.printStackTrace();
					}
					
					//put the node into our hashmap
					nodeIdToNode.put(nodeId, node);
				}
			}

			//get the sequences (aka activites) in the project
			JSONArray sequences = projectJSON.getJSONArray("sequences");

			//loop through all the sequences (aka activities) in the project
			for(int y=0; y<sequences.length(); y++) {
				//get a sequence
				JSONObject sequence = sequences.getJSONObject(y);

				if(sequence != null) {
					//get the seuqnce id
					String sequenceId = sequence.getString("identifier");
					
					//put the sequence into our hashmap (note that sequences are sometimes also referred to as nodes)
					nodeIdToNode.put(sequenceId, sequence);
				}
			}

		} catch (JSONException e) {
			e.printStackTrace();
		}
	}

	/**
	 * Traverse through the project and analyze the steps to find any broken links
	 * @param projectJSON the project JSON
	 * @return a JSONArray that contains JSONObjects for steps that contain broken
	 * links. the JSONObjects contain the step title and a JSONArray of links that
	 * are broken.
	 */
	private JSONArray traverseProject(JSONObject projectJSON) {
		JSONArray results = new JSONArray();
		
		try {
			//get the start point of the project
			String startPoint = projectJSON.getString("startPoint");

			//recursively loop through the project
			results = traverseProjectHelper(startPoint, "");
		} catch (JSONException e) {
			e.printStackTrace();
		}

		return results;
	}

	/**
	 * Recursively loops through the project in sequential order of the steps
	 * in the project and analyzes each step for broken links
	 * @param nodeId the current node id we are on
	 * @param positionSoFar the current position so far
	 * e.g. if we are on activity 2, the position so far would be 2
	 * @return a JSONArray that contains JSONObjects for steps that contain
	 * broken links
	 */
	private JSONArray traverseProjectHelper(String nodeId, String positionSoFar) {
		//the JSONArray that will contain the results
		JSONArray results = new JSONArray();
		
		//get the current node we are on
		JSONObject node = nodeIdToNode.get(nodeId);
		
		if(node == null) {

		} else {
			try {
				if(node.has("type")) {
					//get the node type
					String type = node.getString("type");

					if(type != null && type.equals("sequence")) {
						//node is an activity

						try {
							if(node != null) {
								//get the activity title
								String title = node.getString("title");
								
								//get the steps in the activity
								JSONArray refs = node.getJSONArray("refs");
								
								//create the activity title with activity number e.g. Activity 1: What is light?
								title = "Activity " + positionSoFar + ": " + title;

								//add the mapping of node id to node title
								nodeIdToNodeTitlesWithPosition.put(nodeId, title);
								
								//loop through all the child nodes
								for(int x=0; x<refs.length(); x++) {
									//get the node id of a child node
									String ref = refs.getString(x);
									
									//get the child node
									JSONObject childNode = nodeIdToNode.get(ref);
									
									//get the child node id
									String childNodeId = childNode.getString("identifier");
									
									String newPositonSoFar = "";
									
									if(positionSoFar == null || positionSoFar.equals("")) {
										//position so far is empty so we will just append the number
										newPositonSoFar = positionSoFar + (x + 1);
									} else {
										//position so far is not empty so we will append . and then the number
										newPositonSoFar = positionSoFar + "." + (x + 1);
									}

									//recursively call this function to handle the child node
									JSONArray stepResults = traverseProjectHelper(childNodeId, newPositonSoFar);
									
									if(stepResults != null && stepResults.length() > 0) {
										/*
										 * if stepResults length is greater than 0 it means the step 
										 * has at least one broken link so we will append the elements
										 * to our current results array. the stepResults array will
										 * contain at most one element. this for loop is just for
										 * the future if we change it to contain more than one element. 
										 */
										for(int y=0; y<stepResults.length(); y++) {
											//get an element in the array
											JSONObject stepResult = stepResults.getJSONObject(y);
											
											//add it to our current array
											results.put(stepResult);
										}
									}
								}
							}
						} catch (JSONException e) {
							e.printStackTrace();
						}			
					} else {
						//node is a step

						try {
							//get the step title
							String title = node.getString("title");

							//get the step type
							String nodeType = node.getString("type");
							
							//get the step title with step number e.g. Step 1.2: What is oxygen?
							title = "Step " + positionSoFar + ": " + title + " (" + nodeType + ")";
							
							//add the mapping of node id to node title
							nodeIdToNodeTitlesWithPosition.put(nodeId, title);
							
							//get the content for the step
							JSONObject nodeContent = nodeIdToNodeContent.get(nodeId);
							
							//find any broken links in the step
							JSONArray brokenLinksForStep = findBrokenLinksForStep(nodeContent);
							
							if(brokenLinksForStep != null && brokenLinksForStep.length() != 0) {
								/*
								 * there was at least one broken link so we will create an object
								 * to contain the information for this step and the links that
								 * were broken
								 */
								JSONObject stepResults = new JSONObject();
								stepResults.put("stepTitle", title);
								stepResults.put("brokenLinks", brokenLinksForStep);
								
								//add the object to our results array
								results.put(stepResults);
							}
						} catch (JSONException e) {
							e.printStackTrace();
						}
					}
				}
			} catch (JSONException e1) {
				e1.printStackTrace();
			}
		}

		return results;
	}
	
	/**
	 * Find broken links in the step content
	 * @param nodeContent the step content as a JSONObject
	 * @return a JSONArray of broken link strings
	 */
	private JSONArray findBrokenLinksForStep(JSONObject nodeContent) {
		//the array that will hold all the broken links if any
		JSONArray brokenLinks = new JSONArray();
		
		if(nodeContent == null) {
			
		} else {
			try {
				//get the step type
				String nodeType = nodeContent.getString("type");
				String nodeContentString = "";
				
				if(nodeType == null) {
					
				} else if(nodeType.equals("Html")) {
					//this is an html step so we need to get the html file
					
					//find the name of the html file
					String htmlSrc = nodeContent.getString("src");
					
					//create the local path to the html file
					String htmlSrcPath = projectFolderLocalPath + "/" + htmlSrc;
					
					//create a handle to the html file
					File htmlSrcFile = new File(htmlSrcPath);
					
					try {
						//get the contents of the html file
						nodeContentString = FileUtils.readFileToString(htmlSrcFile);
					} catch (IOException e) {
						e.printStackTrace();
					}
				} else {
					/*
					 * this is not an html step so we already have the 
					 * step content in the nodeContent variable
					 */
					nodeContentString = nodeContent.toString();
				}
				
				/*
				 * create the regex to match strings like these below
				 * 
				 * src="assets/sunlight.jpg"
				 * src=\"assets/sunlight.jpg\"
				 * href="assets/sunlight.jpg"
				 * href=\"assets/sunlight.jpg\"
				 * src="http://www.somewebsite.com/sunlight.jpg"
				 * src=\"http://www.somewebsite.com/sunlight.jpg\"
				 * href="http://www.somewebsite.com/sunlight.jpg"
				 * href=\"http://www.somewebsite.com/sunlight.jpg\"
				 * 
				 */
				String regexString = "(src|href)=\\\\?\"(.*?)\\\\?\"";
				
				//compile the regex string
				Pattern pattern = Pattern.compile(regexString);
				
				//run the regex on the step content
				Matcher matcher = pattern.matcher(nodeContentString);
				
				//loop through the content to find matches
				while(matcher.find()) {
					//used for project assets to remember the relative path reference e.g. assets/sunlight.jpg
					String originalAssetPath = null;
					
					//will contain the path to the asset that is referenced in the step
					String assetPath = null;
					
					/*
					 * loop through all the groups that were captured
					 * "(1)=\\\\?\"(2)\\\\?\""
					 * 
					 * group 0 is the whole match
					 * e.g. src="assets/sunlight.jpg"
					 * 
					 * group 1 is the src or href
					 * e.g. src
					 * 
					 * group 2 is the contents inside the quotes
					 * e.g. assets/sunlight.jpg
					 * 
					 * we could just grab group 2 because that is what we actually care about
					 * but I've looped through all the groups for the sake of easier debugging.
					 * since group 2 is the last group, we will end up with group 2 in our assetPath.
					 */
					for(int x=0; x<=matcher.groupCount(); x++) {
						//get a group
						String group = matcher.group(x);

						if(group != null) {
							//get the asset path
							originalAssetPath = group;
						}
					}
					
					if(originalAssetPath == null) {
						//nothing was captured in the regular expression
					} else if(originalAssetPath.startsWith("http")) {
						//this is a reference to an asset on the web
						assetPath = originalAssetPath;
					} else {
						/*
						 * this is a reference to something in the project folder so
						 * we will prepend the project folder path
						 * 
						 * before
						 * assets/sunlight.jpg
						 * 
						 * after
						 * http://wise4.berkeley.edu/curriculum/123/assets/sunlight.jpg
						 */
						assetPath = projectFolderWebPath + "/" + originalAssetPath;
					}
					
					try {
						//try to access the path and get the response code
						int responseCode = getResponseCode(assetPath);
						
						if(responseCode != 200) {
							//response code is not 200 so we were unable to retrieve the path
							
							/*
							 * if the path begins with http://wise.berkeley.edu we will now try
							 * https://wise.berkeley.edu
							 */
							if(assetPath.startsWith("http://wise.berkeley.edu/")) {
								//add the s
								String secureAssetPath = assetPath.replaceFirst("http", "https");
								
								//try to access the new path
								responseCode = getResponseCode(secureAssetPath);
							}
							
							if(responseCode != 200) {
								/*
								 * the response code is not 200 so we were unable to retrieve the path.
								 * we will add it to our array of broken links
								 */
								brokenLinks.put(originalAssetPath);
							}
						}
					} catch (MalformedURLException e) {
						e.printStackTrace();
					} catch (IOException e) {
						e.printStackTrace();
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
		
		return brokenLinks;
	}
	
	/**
	 * Get the response code for a URL
	 * @param urlString the URL string
	 * @return the response code as an int
	 * @throws MalformedURLException
	 * @throws IOException
	 */
	private static int getResponseCode(String urlString) throws MalformedURLException, IOException {
		//create the URL object
		URL url = new URL(urlString);
		
		//create a connection to the url
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.connect();
		
		//get the response code
		int responseCode = conn.getResponseCode();
		
		return responseCode;
	}

	private String findUnusedAssets() {
		return null;
	}

	/**
	 * Get the full project file path
	 * @param project the project object
	 * @return the full project file path
	 * e.g.
	 * /Users/geoffreykwan/dev/apache-tomcat-5.5.27/webapps/curriculum/667/wise4.project.json
	 */
	private String getProjectFileLocalPath(Project project) {
		String curriculumBaseDir = portalProperties.getProperty("curriculum_base_dir");
		String projectUrl = (String) project.getCurnit().accept(new CurnitGetCurnitUrlVisitor());
		String projectFilePath = curriculumBaseDir + projectUrl;
		return projectFilePath;
	}
	
	/**
	 * Get the full project file path
	 * @param project the project object
	 * @return the full project file path
	 * e.g.
	 * /Users/geoffreykwan/dev/apache-tomcat-5.5.27/webapps/curriculum/667/wise4.project.json
	 */
	private String getProjectFileWebPath(Project project) {
		String curriculumBaseWebDir = portalProperties.getProperty("curriculum_base_www");
		String projectUrl = (String) project.getCurnit().accept(new CurnitGetCurnitUrlVisitor());
		String projectFilePath = curriculumBaseWebDir + projectUrl;
		return projectFilePath;
	}

	/**
	 * Get the full project folder path given the project object
	 * @param project the project object
	 * @return the full project folder path
	 * e.g.
	 * /Users/geoffreykwan/dev/apache-tomcat-5.5.27/webapps/curriculum/667
	 */
	private String getProjectFolderLocalPath(Project project) {
		String projectFilePath = getProjectFileLocalPath(project);
		String projectFolderPath = projectFilePath.substring(0, projectFilePath.lastIndexOf("/"));
		return projectFolderPath;
	}
	
	/**
	 * Get the full project folder path given the project object
	 * @param project the project object
	 * @return the full project folder path
	 * e.g.
	 * /Users/geoffreykwan/dev/apache-tomcat-5.5.27/webapps/curriculum/667
	 */
	private String getProjectFolderWebPath(Project project) {
		String projectFilePath = getProjectFileWebPath(project);
		String projectFolderPath = projectFilePath.substring(0, projectFilePath.lastIndexOf("/"));
		return projectFolderPath;
	}
	
	/**
	 * Get the html view for the results
	 * @param projectResults a JSONArray of project results
	 * @return a string containing the html view of the project results
	 */
	private String getHtmlView(JSONArray projectResults) {
		//the stringbuffer to gather the html
		StringBuffer html = new StringBuffer();
		
		//add the html tags
		html.append("<html><head></head><body>");
		
		//loop through each project result
		for(int x=0; x<projectResults.length(); x++) {
			try {
				//get a project result
				JSONObject projectResult = projectResults.getJSONObject(x);
				
				if(x != 0) {
					//add a horizontal line if this is not the first project result
					html.append("<hr>");
				}
				
				//get the project name and id
				String projectName = projectResult.getString("projectName");
				long projectId = projectResult.getLong("projectId");
				
				//display the project name and id
				html.append("Project Name: " + projectName + "<br>");
				html.append("Project Id: " + projectId + "<br><br>");
				
				//get the steps in the project that have broken links
				JSONArray steps = projectResult.getJSONArray("steps");
				
				if(steps.length() == 0) {
					html.append("There are no broken links.");
				} else {
					//loop through all the steps that have broken links
					for(int y=0; y<steps.length(); y++) {
						//get a step
						JSONObject step = steps.getJSONObject(y);
						
						//add the step title
						String stepTitle = step.getString("stepTitle");
						html.append(stepTitle + "<br>");
						
						//get the broken links
						JSONArray brokenLinks = step.getJSONArray("brokenLinks");
						
						//loop through all the broken links
						for(int z=0; z<brokenLinks.length(); z++) {
							//add the broken link
							String brokenLink = brokenLinks.getString(z);
							html.append(brokenLink + "<br>");
						}
						
						html.append("<br>");
					}
				}
			} catch (JSONException e) {
				e.printStackTrace();
			}
		}
		
		//close the html tags
		html.append("</body></html>");
		
		return html.toString();
	}

	/**
	 * 
	 * @return
	 */
	public ProjectService getProjectService() {
		return projectService;
	}

	/**
	 * 
	 * @param projectService
	 */
	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	/**
	 * @param portalProperties the portalProperties to set
	 */
	public void setPortalProperties(Properties portalProperties) {
		this.portalProperties = portalProperties;
	}
}
