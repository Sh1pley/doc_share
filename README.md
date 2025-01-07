# Project Overview
This project is a platform for teachers to upload and share Markdown documents with students. The platform will allow teachers to easily share documents through unique URLs, which can be accessed by students without requiring an account.

## MVP Target
The target for the MVP is to create a functional document-sharing platform for teachers. The platform should allow teachers to upload Markdown documents, generate unique public URLs for sharing, and display those documents as web pages that students can access. 

### Core Features for MVP:
- Teacher account creation and authentication.
- Document upload and storage.
- Rendering Markdown documents as HTML pages.
- Unique public URLs for each document.
- Basic access control to ensure document security.
- Ability for students to view documents via public links.

## Assumptions
- Teachers are the primary users who will upload documents, while students will only need to view them.
- Markdown is the main document format, with no immediate need for advanced document types (e.g., PDFs).
- Public URLs will be sufficient for students to access documents, so no need for student accounts in the MVP.
- The product should prioritize a simple, clean interface for document upload and viewing.

## Clarifying Questions
These are potential questions that need to be answered in order to refine the project roadmap and ensure the MVP meets expectations.

### Technical and Product Questions:
1. **Document Types**: Are there any other document types (e.g., PDFs, Word documents) that need to be supported in the MVP? Or will we focus on Markdown exclusively?
2. **Design and Branding**: Are there specific design requirements for the document viewer (e.g., style, branding, layout)?
3. **Storage Requirements**: Should documents be stored on a particular cloud service (e.g., AWS S3, Google Cloud Storage), or is it flexible?
4. **Admin Interface**: How robust should the admin interface be in the MVP? Is basic user management sufficient, or are there more specific features needed?

### User Flow and Functional Questions:
5. **Teacher Document Management**: Should teachers be able to delete or edit their documents after uploading? If so, should this be part of the MVP?
6. **Student Access**: Will students need to register for an account, or will they access documents solely through public links?
7. **Multiple Document Versions**: Is version control something that should be considered in the MVP, or is it planned for future releases?
8. **Metrics and Analytics**: Do we need to track document usage or views in the MVP, or is this something to revisit later?

## Prioritized Features and Milestones

| Task                            | Description                                  | Priority   | Estimated Time | Status      |
|---------------------------------|----------------------------------------------|------------|----------------|-------------|
| [ ] Teacher account creation    | Teacher sign up and account creation         | Must Have  | 2 hours        | Basic Implementation |
| [ ] Document upload and storage | Upload and store Markdown documents          | Must Have  | 3 hours        | Started |
| [ ] Markdown rendering          | Render Markdown documents as HTML            | Must Have  | 2 hours        | Not Started |
| [ ] Public file access          | Generate unique public URLs from documents   | Must Have  | 2 hours        | Not Started |
| [ ] Basic admin interface       | Account / Document management                | Should Have| 1 hour         | Not Started |
| [ ] Student accounts            | Implement Student Accounts                   | Should Have| 2 hours        | Not Started |
| [ ] Folder organization         | Organize files into folders                  | Could Have | 2 hours        | Not Started |
| [ ] Buffer/Polish               | Bug fixes and minor improvements             | -          | 1 hour         | Not Started |

## Notes
- **Milestones**:
  - Focus on implementing Must-Have features first to ensure the MVP meets core requirements.
  - Stretch goals (Should-Have and Could-Have) will be implemented if time allows.
- **Feasibility**: Leveraging Rails gems like Devise, Active Storage, and Redcarpet ensures rapid development.
- **Next Steps**: Post-MVP, explore advanced features such as document metrics, version control, and access controls.

## Progress Tracking
As tasks are completed, update the status column with `[x]` to mark them as done.

