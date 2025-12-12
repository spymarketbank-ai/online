import React, { useState, useEffect } from 'react';
import { 
  Container, 
  Row, 
  Col, 
  Card, 
  Form, 
  Button, 
  Alert, 
  Spinner,
  InputGroup
} from 'react-bootstrap';
import { 
  FaEnvelope, 
  FaLock, 
  FaGoogle, 
  FaGithub, 
  FaEye, 
  FaEyeSlash,
  FaUser
} from 'react-icons/fa';
import './LoginBootstrap.css';

function LoginBootstrap() {
  const [formData, setFormData] = useState({
    email: '',
    password: '',
    remember: false
  });
  const [validated, setValidated] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [alert, setAlert] = useState({ show: false, variant: '', message: '' });
  const [isLoading, setIsLoading] = useState(false);
  const [isMobile, setIsMobile] = useState(window.innerWidth <= 768);

  // Détection responsive
  useEffect(() => {
    const handleResize = () => {
      setIsMobile(window.innerWidth <= 768);
    };
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  // Charger l'email sauvegardé
  useEffect(() => {
    const savedEmail = localStorage.getItem('rememberedEmail');
    if (savedEmail) {
      setFormData(prev => ({ ...prev, email: savedEmail, remember: true }));
    }
  }, []);

  // Afficher une alerte
  const showAlert = (variant, message) => {
    setAlert({ show: true, variant, message });
    setTimeout(() => {
      setAlert({ show: false, variant: '', message: '' });
    }, 4000);
  };

  // Gestion des changements
  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };

  // Soumission du formulaire
  const handleSubmit = (e) => {
    e.preventDefault();
    const form = e.currentTarget;

    if (form.checkValidity() === false) {
      e.stopPropagation();
      setValidated(true);
      showAlert('danger', 'Veuillez remplir tous les champs correctement');
      return;
    }

    setValidated(true);
    setIsLoading(true);

    // Simulation d'appel API
    setTimeout(() => {
      setIsLoading(false);

      // Vérification des credentials (REMPLACER PAR VOTRE API)
      if (formData.email === 'demo@example.com' && formData.password === 'demo123') {
        showAlert('success', 'Connexion réussie! Redirection...');

        // Sauvegarder l'email si "Se souvenir"
        if (formData.remember) {
          localStorage.setItem('rememberedEmail', formData.email);
        } else {
          localStorage.removeItem('rememberedEmail');
        }

        // Redirection après succès
        setTimeout(() => {
          console.log('Redirection vers /dashboard');
          // window.location.href = '/dashboard';
        }, 1500);
      } else {
        showAlert('danger', 'Email ou mot de passe incorrect');
      }
    }, 1500);
  };

  // Connexion sociale
  const handleSocialLogin = (provider) => {
    showAlert('info', `Connexion avec ${provider}...`);
    setTimeout(() => {
      console.log(`Redirection vers OAuth ${provider}`);
      // window.location.href = `/auth/${provider.toLowerCase()}`;
    }, 1000);
  };

  return (
    <div className="login-page">
      {/* Bulles animées en arrière-plan */}
      <div className="background-animation">
        {[...Array(5)].map((_, i) => (
          <div key={i} className="bubble"></div>
        ))}
      </div>

      <Container>
        <Row className="justify-content-center align-items-center min-vh-100">
          <Col xs={12} sm={10} md={8} lg={5} xl={4}>
            <Card className="login-card shadow-lg">
              <Card.Body className="p-4 p-md-5">
                {/* En-tête avec avatar */}
                <div className="text-center mb-4">
                  <div className="avatar-circle mb-3">
                    <FaUser size={isMobile ? 30 : 40} />
                  </div>
                  <h2 className="login-title mb-2">Bienvenue</h2>
                  <p className="login-subtitle text-muted">
                    Connectez-vous à votre compte
                  </p>
                </div>

                {/* Alerte */}
                {alert.show && (
                  <Alert 
                    variant={alert.variant} 
                    dismissible 
                    onClose={() => setAlert({ ...alert, show: false })}
                    className="animated-alert"
                  >
                    {alert.message}
                  </Alert>
                )}

                {/* Formulaire */}
                <Form noValidate validated={validated} onSubmit={handleSubmit}>
                  {/* Champ Email */}
                  <Form.Group className="mb-3" controlId="formEmail">
                    <Form.Label className="fw-semibold">
                      <FaEnvelope className="me-2" />
                      Email
                    </Form.Label>
                    <InputGroup hasValidation>
                      <InputGroup.Text className="input-icon">
                        <FaEnvelope />
                      </InputGroup.Text>
                      <Form.Control
                        type="email"
                        name="email"
                        placeholder="exemple@email.com"
                        value={formData.email}
                        onChange={handleChange}
                        required
                        className="custom-input"
                      />
                      <Form.Control.Feedback type="invalid">
                        Veuillez entrer un email valide.
                      </Form.Control.Feedback>
                    </InputGroup>
                  </Form.Group>

                  {/* Champ Mot de passe */}
                  <Form.Group className="mb-3" controlId="formPassword">
                    <Form.Label className="fw-semibold">
                      <FaLock className="me-2" />
                      Mot de passe
                    </Form.Label>
                    <InputGroup hasValidation>
                      <InputGroup.Text className="input-icon">
                        <FaLock />
                      </InputGroup.Text>
                      <Form.Control
                        type={showPassword ? 'text' : 'password'}
                        name="password"
                        placeholder="••••••••"
                        value={formData.password}
                        onChange={handleChange}
                        required
                        minLength={6}
                        className="custom-input"
                      />
                      <Button
                        variant="outline-secondary"
                        onClick={() => setShowPassword(!showPassword)}
                        className="password-toggle"
                      >
                        {showPassword ? <FaEyeSlash /> : <FaEye />}
                      </Button>
                      <Form.Control.Feedback type="invalid">
                        Le mot de passe doit contenir au moins 6 caractères.
                      </Form.Control.Feedback>
                    </InputGroup>
                  </Form.Group>

                  {/* Options */}
                  <div className="d-flex justify-content-between align-items-center mb-4">
                    <Form.Check
                      type="checkbox"
                      id="rememberCheck"
                      name="remember"
                      label="Se souvenir de moi"
                      checked={formData.remember}
                      onChange={handleChange}
                      className="custom-checkbox"
                    />
                    <a 
                      href="#" 
                      className="forgot-link text-decoration-none"
                      onClick={(e) => {
                        e.preventDefault();
                        showAlert('info', 'Fonctionnalité de récupération en cours...');
                      }}
                    >
                      Mot de passe oublié?
                    </a>
                  </div>

                  {/* Bouton de connexion */}
                  <Button
                    variant="primary"
                    type="submit"
                    className="w-100 login-btn mb-3"
                    size={isMobile ? 'md' : 'lg'}
                    disabled={isLoading}
                  >
                    {isLoading ? (
                      <>
                        <Spinner
                          as="span"
                          animation="border"
                          size="sm"
                          role="status"
                          aria-hidden="true"
                          className="me-2"
                        />
                        Connexion...
                      </>
                    ) : (
                      'Se connecter'
                    )}
                  </Button>
                </Form>

                {/* Séparateur */}
                <div className="divider-container">
                  <hr className="divider-line" />
                  <span className="divider-text">OU</span>
                  <hr className="divider-line" />
                </div>

                {/* Boutons sociaux */}
                <Row className="g-2 mb-4">
                  <Col xs={12} sm={6}>
                    <Button
                      variant="outline-danger"
                      className="w-100 social-btn"
                      onClick={() => handleSocialLogin('Google')}
                    >
                      <FaGoogle className="me-2" />
                      Google
                    </Button>
                  </Col>
                  <Col xs={12} sm={6}>
                    <Button
                      variant="outline-dark"
                      className="w-100 social-btn"
                      onClick={() => handleSocialLogin('GitHub')}
                    >
                      <FaGithub className="me-2" />
                      GitHub
                    </Button>
                  </Col>
                </Row>

                {/* Footer */}
                <div className="text-center">
                  <p className="text-muted mb-0">
                    Pas encore de compte?{' '}
                    <a 
                      href="#" 
                      className="signup-link text-decoration-none fw-bold"
                      onClick={(e) => {
                        e.preventDefault();
                        console.log('Redirection vers inscription');
                      }}
                    >
                      S'inscrire
                    </a>
                  </p>
                </div>

                {/* Credentials de test */}
                <div className="text-center mt-3 test-credentials">
                  <small className="text-muted d-block">
                    <strong>Test:</strong> demo@example.com / demo123
                  </small>
                </div>
              </Card.Body>
            </Card>
          </Col>
        </Row>
      </Container>
    </div>
  );
}

export default LoginBootstrap;
