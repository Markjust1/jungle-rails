/// <reference types="cypress" />

describe('example to-do app', () => {

  beforeEach(() => {
    // Visits home page before every test
    cy.visit('/')
  })
/////////////////////////////////////////////////////////////
  // it('should display the list of products on the main page', () => {
  //   // checks if container exists 
  //   cy.get('.products').should('exist')
  //   cy.get('#products-list').should('exist')
  // })
/////////////////////////////////////////////////////////////
  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
/////////////////////////////////////////////////////////////
  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });



})