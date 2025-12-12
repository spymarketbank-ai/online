import React, { useState, useEffect } from 'react';

const Login = () => {
  const [formData, setFormData] = useState({
    email: '',
    password: '',
    remember: false
  });
  const [message, setMessage] = useState({ text: '', type: '' });
  const [isLoading, setIsLoading] = useState(false);
  const [inputsLoaded, setInputsLoaded] = useState(false);
  const [windowWidth, setWindowWidth] = useState(window.innerWidth);

  // Détecter la taille de l'écran
  useEffect(() => {
    const handleResize = () => setWindowWidth(window.innerWidth);
    window.addEventListener('resize', handleResize);
    return () => window.removeEventListener('resize', handleResize);
  }, []);

  // Animation au chargement
  useEffect(() => {
    setTimeout(() => setInputsLoaded(true), 100);
  }, []);

  // Breakpoints responsive
  const isMobile = windowWidth <= 480;
  const isTablet = windowWidth > 480 && windowWidth <= 768;
  const isDesktop = windowWidth > 768;

  // Gestion des changements de formulaire
  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };

  // Validation email
  const isValidEmail = (email) => {
    const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return regex.test(email);
  };

  // Afficher un message
  const showMessage = (text, type) => {
    setMessage({ text, type });
    setTimeout(() => setMessage({ text: '', type: '' }), 4000);
  };

  // Soumission du formulaire
  const handleSubmit = async (e) => {
    e.preventDefault();

    // Validation
    if (!formData.email || !formData.password) {
      showMessage('Veuillez remplir tous les champs', 'error');
      return;
    }

    if (!isValidEmail(formData.email)) {
      showMessage('Veuillez entrer un email valide', 'error');
      return;
    }

    // Animation de chargement
    setIsLoading(true);

    // Simulation d'une requête API (remplacer par votre API)
    setTimeout(() => {
      setIsLoading(false);

      // Exemple de succès (à adapter selon votre backend)
      if (formData.email === 'demo@example.com' && formData.password === 'demo123') {
        showMessage('Connexion réussie! Redirection...', 'success');
        setTimeout(() => {
          // Redirection vers le dashboard
          // window.location.href = '/dashboard';
          console.log('Redirection vers le dashboard...');
        }, 1500);
      } else {
        showMessage('Email ou mot de passe incorrect', 'error');
      }
    }, 1500);
  };

  // Connexions sociales
  const handleSocialLogin = (provider) => {
    showMessage(`Connexion avec ${provider}...`, 'success');
    // Implémenter la connexion OAuth
  };

  // Effet ripple
  const createRipple = (e) => {
    const ripple = document.createElement('div');
    ripple.style.cssText = `
      position: absolute;
      width: 10px;
      height: 10px;
      background: rgba(255, 255, 255, 0.5);
      border-radius: 50%;
      left: ${e.clientX}px;
      top: ${e.clientY}px;
      pointer-events: none;
      transform: translate(-50%, -50%);
      animation: ripple 1s ease-out;
    `;
    document.body.appendChild(ripple);
    setTimeout(() => ripple.remove(), 1000);
  };

  useEffect(() => {
    const handleClick = (e) => createRipple(e);
    document.addEventListener('click', handleClick);
    return () => document.removeEventListener('click', handleClick);
  }, []);

  const styles = {
    container: {
      margin: 0,
      padding: isMobile ? '15px' : '20px',
      boxSizing: 'border-box',
      fontFamily: "'Segoe UI', Tahoma, Geneva, Verdana, sans-serif",
      minHeight: '100vh',
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
      overflow: isMobile ? 'auto' : 'hidden',
      position: 'relative'
    },
    backgroundAnimation: {
      position: 'absolute',
      width: '100%',
      height: '100%',
      overflow: 'hidden',
      zIndex: 0,
      display: isMobile ? 'none' : 'block' // Masquer les bulles sur mobile pour la performance
    },
    bubble: (index) => ({
      position: 'absolute',
      bottom: '-100px',
      background: 'rgba(255, 255, 255, 0.1)',
      borderRadius: '50%',
      animation: `rise ${[8, 10, 12, 9, 11][index]}s infinite ease-in`,
      animationDelay: `${[0, 2, 4, 1, 3][index]}s`,
      width: isMobile ? ['50px', '40px', '60px', '45px', '55px'][index] : ['80px', '60px', '100px', '70px', '90px'][index],
      height: isMobile ? ['50px', '40px', '60px', '45px', '55px'][index] : ['80px', '60px', '100px', '70px', '90px'][index],
      left: ['10%', '30%', '50%', '70%', '85%'][index]
    }),
    loginContainer: {
      position: 'relative',
      zIndex: 1,
      background: 'rgba(255, 255, 255, 0.15)',
      backdropFilter: 'blur(10px)',
      padding: isMobile ? '30px 20px' : isTablet ? '40px 30px' : '50px 40px',
      borderRadius: isMobile ? '15px' : '20px',
      boxShadow: '0 8px 32px 0 rgba(31, 38, 135, 0.37)',
      border: '1px solid rgba(255, 255, 255, 0.18)',
      width: isMobile ? '100%' : isTablet ? '85%' : '400px',
      maxWidth: isMobile ? '100%' : isTablet ? '500px' : '400px',
      animation: 'slideIn 0.6s ease-out',
      margin: isMobile ? '10px' : '20px'
    },
    loginHeader: {
      textAlign: 'center',
      marginBottom: isMobile ? '25px' : isTablet ? '30px' : '40px'
    },
    title: {
      color: 'white',
      fontSize: isMobile ? '24px' : isTablet ? '28px' : '32px',
      marginBottom: isMobile ? '5px' : '10px',
      textShadow: '2px 2px 4px rgba(0, 0, 0, 0.2)',
      fontWeight: 700
    },
    subtitle: {
      color: 'rgba(255, 255, 255, 0.8)',
      fontSize: isMobile ? '12px' : '14px'
    },
    avatar: {
      width: isMobile ? '60px' : isTablet ? '70px' : '80px',
      height: isMobile ? '60px' : isTablet ? '70px' : '80px',
      background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
      borderRadius: '50%',
      margin: isMobile ? '0 auto 15px' : '0 auto 20px',
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      boxShadow: '0 4px 15px rgba(0, 0, 0, 0.2)',
      animation: 'pulse 2s infinite'
    },
    formGroup: {
      marginBottom: isMobile ? '18px' : '25px',
      position: 'relative',
      opacity: inputsLoaded ? 1 : 0,
      transform: inputsLoaded ? 'translateX(0)' : 'translateX(-20px)',
      transition: 'all 0.5s ease'
    },
    label: {
      display: 'block',
      color: 'white',
      marginBottom: isMobile ? '6px' : '8px',
      fontSize: isMobile ? '13px' : '14px',
      fontWeight: 500
    },
    inputWrapper: {
      position: 'relative'
    },
    input: {
      width: '100%',
      padding: isMobile ? '13px 13px 13px 40px' : '15px 15px 15px 45px',
      border: '2px solid rgba(255, 255, 255, 0.3)',
      borderRadius: isMobile ? '8px' : '10px',
      background: 'rgba(255, 255, 255, 0.1)',
      color: 'white',
      fontSize: isMobile ? '14px' : '15px',
      transition: 'all 0.3s ease',
      outline: 'none',
      WebkitAppearance: 'none',
      appearance: 'none'
    },
    inputIcon: {
      position: 'absolute',
      left: isMobile ? '12px' : '15px',
      top: '50%',
      transform: 'translateY(-50%)',
      color: 'rgba(255, 255, 255, 0.6)',
      transition: 'color 0.3s ease',
      pointerEvents: 'none'
    },
    formOptions: {
      display: 'flex',
      flexDirection: isMobile ? 'column' : 'row',
      justifyContent: 'space-between',
      alignItems: isMobile ? 'flex-start' : 'center',
      marginBottom: isMobile ? '15px' : '20px',
      fontSize: isMobile ? '12px' : '14px',
      gap: isMobile ? '10px' : '0'
    },
    rememberMe: {
      display: 'flex',
      alignItems: 'center',
      color: 'white',
      cursor: 'pointer'
    },
    checkbox: {
      width: 'auto',
      marginRight: '8px',
      cursor: 'pointer',
      padding: 0
    },
    forgotPassword: {
      color: 'white',
      textDecoration: 'none',
      transition: 'all 0.3s ease',
      cursor: 'pointer',
      fontSize: isMobile ? '12px' : '14px'
    },
    loginButton: {
      width: '100%',
      padding: isMobile ? '13px' : '15px',
      border: 'none',
      borderRadius: isMobile ? '8px' : '10px',
      background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
      color: 'white',
      fontSize: isMobile ? '15px' : '16px',
      fontWeight: 600,
      cursor: isLoading ? 'not-allowed' : 'pointer',
      transition: 'all 0.3s ease',
      boxShadow: '0 4px 15px rgba(0, 0, 0, 0.2)',
      position: 'relative',
      overflow: 'hidden',
      opacity: isLoading ? 0.7 : 1,
      WebkitTapHighlightColor: 'transparent'
    },
    message: {
      padding: isMobile ? '10px' : '12px',
      borderRadius: isMobile ? '6px' : '8px',
      marginBottom: isMobile ? '15px' : '20px',
      fontSize: isMobile ? '12px' : '14px',
      display: message.text ? 'block' : 'none',
      animation: 'shake 0.5s',
      background: message.type === 'error' ? 'rgba(244, 67, 54, 0.2)' : 'rgba(76, 175, 80, 0.2)',
      border: message.type === 'error' ? '1px solid rgba(244, 67, 54, 0.5)' : '1px solid rgba(76, 175, 80, 0.5)',
      color: message.type === 'error' ? '#ffcdd2' : '#c8e6c9'
    },
    divider: {
      display: 'flex',
      alignItems: 'center',
      margin: isMobile ? '20px 0' : '25px 0'
    },
    dividerLine: {
      flex: 1,
      height: '1px',
      background: 'rgba(255, 255, 255, 0.3)'
    },
    dividerText: {
      padding: isMobile ? '0 10px' : '0 15px',
      color: 'rgba(255, 255, 255, 0.8)',
      fontSize: isMobile ? '12px' : '14px',
      whiteSpace: 'nowrap'
    },
    socialLogin: {
      display: 'flex',
      flexDirection: isMobile ? 'column' : 'row',
      gap: isMobile ? '8px' : '10px',
      marginTop: isMobile ? '15px' : '20px'
    },
    socialButton: {
      flex: 1,
      padding: isMobile ? '11px' : '12px',
      border: '2px solid rgba(255, 255, 255, 0.3)',
      borderRadius: isMobile ? '8px' : '10px',
      background: 'rgba(255, 255, 255, 0.1)',
      color: 'white',
      cursor: 'pointer',
      transition: 'all 0.3s ease',
      display: 'flex',
      justifyContent: 'center',
      alignItems: 'center',
      gap: '8px',
      fontSize: isMobile ? '13px' : '14px',
      WebkitTapHighlightColor: 'transparent',
      minHeight: isMobile ? '45px' : 'auto'
    },
    loginFooter: {
      textAlign: 'center',
      marginTop: isMobile ? '20px' : '30px',
      color: 'rgba(255, 255, 255, 0.8)',
      fontSize: isMobile ? '12px' : '14px'
    },
    link: {
      color: 'white',
      textDecoration: 'none',
      fontWeight: 600,
      cursor: 'pointer'
    }
  };

  return (
    <>
      <style>
        {`
          * {
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
          }

          @keyframes rise {
            0% {
              bottom: -100px;
              transform: translateX(0) rotate(0deg);
              opacity: 0;
            }
            50% {
              opacity: 1;
            }
            100% {
              bottom: 110vh;
              transform: translateX(100px) rotate(360deg);
              opacity: 0;
            }
          }

          @keyframes slideIn {
            from {
              opacity: 0;
              transform: translateY(-30px);
            }
            to {
              opacity: 1;
              transform: translateY(0);
            }
          }

          @keyframes pulse {
            0%, 100% {
              transform: scale(1);
            }
            50% {
              transform: scale(1.05);
            }
          }

          @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
          }

          @keyframes ripple {
            to {
              width: 100px;
              height: 100px;
              opacity: 0;
            }
          }

          @keyframes spin {
            to { transform: rotate(360deg); }
          }

          input::placeholder {
            color: rgba(255, 255, 255, 0.5);
          }

          input:focus {
            border-color: white !important;
            background: rgba(255, 255, 255, 0.2) !important;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
          }

          .login-button:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
          }

          .login-button:active:not(:disabled) {
            transform: translateY(0);
          }

          .social-button:hover {
            background: rgba(255, 255, 255, 0.2) !important;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
          }

          .social-button:active {
            transform: translateY(0);
          }

          .forgot-password:hover {
            text-decoration: underline;
          }

          .link:hover {
            text-decoration: underline;
          }

          ${isLoading ? `
            .login-button::after {
              content: '';
              position: absolute;
              width: 20px;
              height: 20px;
              top: 50%;
              left: 50%;
              margin-left: -10px;
              margin-top: -10px;
              border: 3px solid rgba(255, 255, 255, 0.3);
              border-top-color: white;
              border-radius: 50%;
              animation: spin 0.8s linear infinite;
            }
          ` : ''}

          /* Media Queries détaillées */
          
          /* Très petits mobiles (320px - 375px) */
          @media (max-width: 375px) {
            .login-container {
              padding: 25px 15px !important;
              margin: 5px !important;
            }
            
            .title {
              font-size: 22px !important;
            }
            
            .social-button {
              font-size: 12px !important;
              padding: 10px !important;
            }
          }

          /* Mobiles (376px - 480px) */
          @media (min-width: 376px) and (max-width: 480px) {
            .login-container {
              padding: 30px 20px !important;
            }
          }

          /* Tablettes portrait (481px - 768px) */
          @media (min-width: 481px) and (max-width: 768px) {
            .login-container {
              max-width: 500px !important;
            }
            
            .social-login {
              flex-direction: row !important;
            }
          }

          /* Tablettes paysage (769px - 1024px) */
          @media (min-width: 769px) and (max-width: 1024px) {
            .login-container {
              max-width: 450px !important;
            }
          }

          /* Desktop (1025px+) */
          @media (min-width: 1025px) {
            .login-button:hover:not(:disabled) {
              transform: translateY(-3px);
            }
            
            input:focus {
              transform: translateY(-3px);
            }
          }

          /* Mode paysage mobile */
          @media (max-height: 600px) and (orientation: landscape) {
            .login-container {
              padding: 20px 30px !important;
              margin: 10px auto !important;
              max-height: 95vh;
              overflow-y: auto;
            }
            
            .avatar {
              width: 50px !important;
              height: 50px !important;
              margin-bottom: 10px !important;
            }
            
            .login-header {
              margin-bottom: 20px !important;
            }
            
            .title {
              font-size: 20px !important;
              margin-bottom: 5px !important;
            }
            
            .subtitle {
              font-size: 11px !important;
            }
            
            .form-group {
              margin-bottom: 15px !important;
            }
            
            .divider {
              margin: 15px 0 !important;
            }
            
            .social-login {
              margin-top: 10px !important;
            }
            
            .login-footer {
              margin-top: 15px !important;
            }
          }

          /* Très grands écrans (1440px+) */
          @media (min-width: 1440px) {
            .login-container {
              max-width: 450px !important;
              padding: 60px 50px !important;
            }
          }

          /* Préférence de mouvement réduit */
          @media (prefers-reduced-motion: reduce) {
            * {
              animation-duration: 0.01ms !important;
              animation-iteration-count: 1 !important;
              transition-duration: 0.01ms !important;
            }
          }

          /* Support tactile */
          @media (hover: none) and (pointer: coarse) {
            .login-button,
            .social-button {
              min-height: 48px;
              touch-action: manipulation;
            }
            
            input {
              font-size: 16px !important; /* Évite le zoom automatique sur iOS */
            }
          }

          /* Mode sombre du système */
          @media (prefers-color-scheme: dark) {
            input::placeholder {
              color: rgba(255, 255, 255, 0.6);
            }
          }

          /* Amélioration du scroll sur mobile */
          @media (max-width: 768px) {
            body {
              -webkit-overflow-scrolling: touch;
            }
          }
        `}
      </style>

      <div style={styles.container}>
        {!isMobile && (
          <div style={styles.backgroundAnimation}>
            {[0, 1, 2, 3, 4].map((index) => (
              <div key={index} style={styles.bubble(index)} />
            ))}
          </div>
        )}

        <div style={styles.loginContainer} className="login-container">
          <div style={styles.loginHeader} className="login-header">
            <div style={styles.avatar} className="avatar">
              <svg 
                width={isMobile ? "30" : isTablet ? "35" : "40"} 
                height={isMobile ? "30" : isTablet ? "35" : "40"} 
                viewBox="0 0 24 24" 
                fill="white"
              >
                <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 3c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 14.2c-2.5 0-4.71-1.28-6-3.22.03-1.99 4-3.08 6-3.08 1.99 0 5.97 1.09 6 3.08-1.29 1.94-3.5 3.22-6 3.22z"/>
              </svg>
            </div>
            <h1 style={styles.title} className="title">Bienvenue</h1>
            <p style={styles.subtitle} className="subtitle">Connectez-vous à votre compte</p>
          </div>

          {message.text && (
            <div style={styles.message}>
              {message.text}
            </div>
          )}

          <form onSubmit={handleSubmit}>
            <div style={{...styles.formGroup, transitionDelay: '0ms'}} className="form-group">
              <label style={styles.label} htmlFor="email">Email</label>
              <div style={styles.inputWrapper}>
                <input
                  type="email"
                  id="email"
                  name="email"
                  value={formData.email}
                  onChange={handleChange}
                  placeholder="exemple@email.com"
                  style={styles.input}
                  required
                />
                <span style={styles.inputIcon}>
                  <svg width={isMobile ? "18" : "20"} height={isMobile ? "18" : "20"} viewBox="0 0 24 24" fill="currentColor">
                    <path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/>
                  </svg>
                </span>
              </div>
            </div>

            <div style={{...styles.formGroup, transitionDelay: '100ms'}} className="form-group">
              <label style={styles.label} htmlFor="password">Mot de passe</label>
              <div style={styles.inputWrapper}>
                <input
                  type="password"
                  id="password"
                  name="password"
                  value={formData.password}
                  onChange={handleChange}
                  placeholder="••••••••"
                  style={styles.input}
                  required
                />
                <span style={styles.inputIcon}>
                  <svg width={isMobile ? "18" : "20"} height={isMobile ? "18" : "20"} viewBox="0 0 24 24" fill="currentColor">
                    <path d="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z"/>
                  </svg>
                </span>
              </div>
            </div>

            <div style={styles.formOptions}>
              <label style={styles.rememberMe}>
                <input
                  type="checkbox"
                  name="remember"
                  checked={formData.remember}
                  onChange={handleChange}
                  style={styles.checkbox}
                />
                <span>Se souvenir</span>
              </label>
              <a href="#" style={styles.forgotPassword} className="forgot-password">
                Mot de passe oublié?
              </a>
            </div>

            <button 
              type="submit" 
              style={styles.loginButton}
              className="login-button"
              disabled={isLoading}
            >
              {!isLoading && 'Se connecter'}
            </button>
          </form>

          <div style={styles.divider} className="divider">
            <div style={styles.dividerLine} />
            <span style={styles.dividerText}>OU</span>
            <div style={styles.dividerLine} />
          </div>

          <div style={styles.socialLogin} className="social-login">
            <button 
              style={styles.socialButton}
              className="social-button"
              onClick={() => handleSocialLogin('Google')}
              type="button"
            >
              <svg width={isMobile ? "18" : "20"} height={isMobile ? "18" : "20"} viewBox="0 0 24 24" fill="currentColor">
                <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
                <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
                <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
                <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
              </svg>
              Google
            </button>
            <button 
              style={styles.socialButton}
              className="social-button"
              onClick={() => handleSocialLogin('GitHub')}
              type="button"
            >
              <svg width={isMobile ? "18" : "20"} height={isMobile ? "18" : "20"} viewBox="0 0 24 24" fill="currentColor">
                <path d="M12 2C6.477 2 2 6.477 2 12c0 4.42 2.865 8.17 6.839 9.49.5.092.682-.217.682-.482 0-.237-.008-.866-.013-1.7-2.782.603-3.369-1.34-3.369-1.34-.454-1.156-1.11-1.463-1.11-1.463-.908-.62.069-.608.069-.608 1.003.07 1.531 1.03 1.531 1.03.892 1.529 2.341 1.087 2.91.831.092-.646.35-1.086.636-1.336-2.22-.253-4.555-1.11-4.555-4.943 0-1.091.39-1.984 1.029-2.683-.103-.253-.446-1.27.098-2.647 0 0 .84-.269 2.75 1.025A9.578 9.578 0 0112 6.836c.85.004 1.705.114 2.504.336 1.909-1.294 2.747-1.025 2.747-1.025.546 1.377.203 2.394.1 2.647.64.699 1.028 1.592 1.028 2.683 0 3.842-2.339 4.687-4.566 4.935.359.309.678.919.678 1.852 0 1.336-.012 2.415-.012 2.743 0 .267.18.578.688.48C19.138 20.167 22 16.418 22 12c0-5.523-4.477-10-10-10z"/>
              </svg>
              GitHub
            </button>
          </div>

          <div style={styles.loginFooter} className="login-footer">
            Pas encore de compte? <a href="#" style={styles.link} className="link">S'inscrire</a>
          </div>
        </div>
      </div>
    </>
  );
};

export default Login;
