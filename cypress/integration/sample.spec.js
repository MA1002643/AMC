describe('Homepage Test', () => {
  it('should load the homepage', () => {
    cy.visit('/');
    cy.contains('Welcome to Afaaq Mobile').should('be.visible');
  });
});
