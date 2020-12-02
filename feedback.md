# Media Ranker

<!-- Instructors: The checkmarks are already there, so just delete them for any line items that aren't met. -->

<!-- Instructions:

Limit your in-line comments on this one. Also, the manual testing is huge, but covers eeeeverything, so if there's anything to comment on as constructive feedback, the manual testing should point you right to it with any line that has the answer "no"
-->

## Functional Requirements: Manual Testing

| Criteria | yes/no |
| --- | --- |
| **Before logging in** | --
| 1. On index page, there are at most 10 pieces of media on three lists, and a Media Spotlight | ✔️?
| 2. Can go into a work's show page | ✔️?
| 3. Verify unable to vote on a work, and get a flash message | ✔️?
| 4. Can edit this work successfully, and get a flash message | ✔️?
| 5. Can go to "View all media" page and see three lists of works, sorted by vote | ✔️?
| 6. Verify unable to create a new work when the form is empty, and details about the validation errors are visible to the user through a flash message | ✔️?
| 7. Can create a new work successfully. Note the URL for this work's show page | ✔️?
| 8. Can delete this work successfully |✔️?
| 9. Going back to the URL of this deleted work's show page produces a 404 or some redirect behavior (and does not try to produce a broken view) | ✔️?
| 10. Verify that the "View all users" page lists no users | ✔️?
| **Log in** | --
| 11. Logging in with a valid name changes the UI to "Logged in as" and "Logout" buttons | ✔️?
| 12. Your username is listed in "View all users" page | ✔️?
| 13. Verify that number of votes determines the Media Spotlight | ✔️?
| 14. Voting on several different pieces of media affects the "Votes" tables shown in the work's show page and the user's show page | ✔️?
| 15. Voting on the same work twice produces an error and flash message, and there is no extra vote | ✔️?
| **Log out** | --
| 16. Logging out showed a flash message and changed the UI | ✔️?
| 17. Logging in as a new user creates a new user | ✔️?
| 18. Logging in as an already existing user has a specific flash message | ✔️?

## Major Learning Goals/Code Review

| Criteria | yes/no |
| --- | --- |
| 1. Sees the full development cycle including deployment, and the app is deployed to Heroku | ✔️?
| 2. Practices full-stack development and fulfilling story requirements: the styling, look, and feel of the app is similar to the original Media Ranker | ✔️?
| 3. Practices git with at least 25 small commits and meaningful commit messages | ✔️?

### Previous Rails learning, Building Complex Model Logic, DRYing up Rails Code

| Criteria | yes/no |
| --- | --- |
| 4. Routes file uses `resources` for works | ✔️?
| 5. Routes file shows intention in limiting routes for voting, log-in functionality, and users | ✔️?
| 6. The homepage view, all media view, and new works view use semantic HTML | ✔️?
| 7. The homepage view, all media view, and new works view use partials when appropriate | ✔️?
| 8. The model for media (likely named `work.rb`) `has_many` votes | ✔️?
| 9. The model for media has methods to describe business logic, specifically for top ten and top media, possibly also for getting works by some category | ✔️?
| 10. Some controller, likely the `ApplicationController`, has a controller filter for finding a logged in user | ✔️?
| 11. Some controller, likely the `WorksController`, has a controller filter for finding a work | ✔️?
| 12. The `WorksController` uses strong params | ✔️?
| 13. The `WorksController`'s code style is clean, and focused on working with requests, responses, `params`, `session`, `flash` | ✔️?

### Testing Rails Apps

| Criteria | yes/no |
| --- | --- |
| 14. There are valid fixtures files used for users, votes, and works | ✔️?
| 15. User model has tests with sections on validations (valid and invalid) and relationships (has votes) | ✔️?
| 16. Vote model has tests with sections on validations (valid and invalid) and relationships (belongs to a user, belongs to a vote) | ✔️?
| 17. Work model has tests with sections on validations (valid and invalid) and relationships (has votes) | ✔️?
| 18. Work model has tests with a section on all business logic methods in the model, including their edge cases | ✔️?

## Overall Feedback

| Overall Feedback | Criteria | yes/no |
| --- | --- | --- |
| Green (Meets/Exceeds Standards) | 14+ in Functional Requirements: Manual Testing && 14+ in Code Review | 
| Yellow (Approaches Standards) | 12+ in Functional Requirements: Manual Testing && 11+ in Code Review, or the instructor judges that this project needs special attention | 
| Red (Not at Standard) | 0-10 in Code Review or 0-11 in Functional Reqs, or assignment is breaking/doesn’t run with less than 5 minutes of debugging, or the instructor judges that this project needs special attention | 

<!-- ### Additional Feedback -->

<!-- Instructors, feel free to ignore this section if there's nothing else to add. -->

## Code Style Bonus Awards

<!-- Instructors: Please strike a balance between liberal/stingy with these. These are simply built-in pieces of positive feedback; use this to encourage and push students towards a cleaner code style! -->

Was the code particularly impressive in code style for any of these reasons (or more...?)

| Quality | Yes? |
| --- | --- |
| Perfect Indentation | ✅
| Elegant/Clever | ✅
| Descriptive/Readable | ✅
| Concise | ✅
| Logical/Organized | ✅