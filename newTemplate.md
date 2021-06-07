  # Notes for build 
  **Build Number**: {{buildDetails.id}}
  **Build Trigger PR Number**: {{lookup buildDetails.triggerInfo 'pr.number'}} 

  # Associated Pull Requests ({{pullRequests.length}})
  {{#forEach pullRequests}}
  {{#if isFirst}}### Associated Pull Requests (only shown if  PR) {{/if}}
  *  **PR {{this.id}}**  {{this.title}}
  {{/forEach}}

  # Builds with associated WI/CS ({{builds.length}})
  {{#forEach builds}}
  {{#if isFirst}}## Builds {{/if}}
  ##  Build {{this.build.buildNumber}}
  {{#forEach this.commits}}
  {{#if isFirst}}### Commits {{/if}}
  - CS {{this.id}}
  {{/forEach}}
  {{#forEach this.workitems}}
  {{#if isFirst}}### Workitems {{/if}}
  - WI {{this.id}}
  {{/forEach}} 
  {{/forEach}}

  # Global list of WI ({{workItems.length}})
  {{#forEach workItems}}
  {{#if isFirst}}## Associated Work Items (only shown if  WI) {{/if}}
  *  **{{this.id}}**  {{lookup this.fields 'System.Title'}}
    - **WIT** {{lookup this.fields 'System.WorkItemType'}} 
    - **Tags** {{lookup this.fields 'System.Tags'}}
  {{/forEach}}

  {{#forEach commits}}
  {{#if isFirst}}### Associated commits{{/if}}
  * ** ID{{this.id}}** 
    -  **Message:** {{this.message}}
    -  **Commited by:** {{this.author.displayName}} 
    -  **FileCount:** {{this.changes.length}} 
  {{#forEach this.changes}}
        -  **File path (TFVC or TfsGit):** {{this.item.path}}  
        -  **File filename (GitHub):** {{this.filename}}  
  {{/forEach}}
  {{/forEach}}
