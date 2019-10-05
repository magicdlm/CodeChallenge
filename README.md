# CodeChallenge
The focus is on making service (more specifically, how to build the http request) independent from the Model (data)

Builder Pattern: to standardize the request building process while giving flexible custumizaion over each steps, to support dynamic backend systems.

Visitor Pattern: to maximum the reusability of existing request builders when adding a new data model. (by conforming to httpBodyRepresentable)
