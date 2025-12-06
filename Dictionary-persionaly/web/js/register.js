// Register Page - Validation & Password Strength Indicator
document.addEventListener('DOMContentLoaded', function() {
    // Form elements
    const form = document.getElementById('registerForm');
    const emailInput = document.getElementById('email');
    const fullNameInput = document.getElementById('fullName');
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    const agreeTermsCheckbox = document.getElementById('agreeTerms');
    const submitBtn = document.getElementById('submitBtn');
    
    // Error elements
    const emailError = document.getElementById('emailError');
    const fullNameError = document.getElementById('fullNameError');
    const passwordError = document.getElementById('passwordError');
    const confirmPasswordError = document.getElementById('confirmPasswordError');
    
    // Password strength elements
    const strengthContainer = document.getElementById('passwordStrength');
    const strengthBar = document.getElementById('strengthBar');
    const strengthText = document.getElementById('strengthText');
    
    // Password toggle functionality
    setupPasswordToggle('password', 'passwordToggle');
    setupPasswordToggle('confirmPassword', 'confirmPasswordToggle');
    
    // Password Strength Indicator
    passwordInput.addEventListener('input', function() {
        const password = passwordInput.value;
        
        if (password.length === 0) {
            strengthContainer.style.display = 'none';
            return;
        }
        
        strengthContainer.style.display = 'block';
        const strength = calculatePasswordStrength(password);
        updateStrengthUI(strength);
    });
    
    // Email validation
    emailInput.addEventListener('blur', validateEmail);
    emailInput.addEventListener('input', function() {
        if (emailInput.style.borderColor === 'rgb(220, 38, 38)') {
            emailInput.style.borderColor = '#e5e7eb';
            emailError.textContent = '';
        }
    });
    
    // Full name validation
    fullNameInput.addEventListener('blur', validateFullName);
    fullNameInput.addEventListener('input', function() {
        if (fullNameInput.style.borderColor === 'rgb(220, 38, 38)') {
            fullNameInput.style.borderColor = '#e5e7eb';
            fullNameError.textContent = '';
        }
    });
    
    // Password validation
    passwordInput.addEventListener('blur', validatePassword);
    passwordInput.addEventListener('input', function() {
        if (passwordInput.style.borderColor === 'rgb(220, 38, 38)') {
            passwordInput.style.borderColor = '#e5e7eb';
            passwordError.textContent = '';
        }
    });
    
    // Confirm password validation
    confirmPasswordInput.addEventListener('blur', validateConfirmPassword);
    confirmPasswordInput.addEventListener('input', function() {
        if (confirmPasswordInput.style.borderColor === 'rgb(220, 38, 38)') {
            confirmPasswordInput.style.borderColor = '#e5e7eb';
            confirmPasswordError.textContent = '';
        }
    });
    
    // Form submission
    form.addEventListener('submit', function(e) {
        let isValid = true;
        
        // Clear all errors
        clearAllErrors();
        
        // Validate all fields
        if (!validateEmail()) isValid = false;
        if (!validateFullName()) isValid = false;
        if (!validatePassword()) isValid = false;
        if (!validateConfirmPassword()) isValid = false;
        
        // Check terms agreement
        if (!agreeTermsCheckbox.checked) {
            alert('Vui lòng đồng ý với Điều khoản sử dụng và Chính sách bảo mật');
            isValid = false;
        }
        
        if (!isValid) {
            e.preventDefault();
            
            // Scroll to first error
            const firstError = document.querySelector('.input-error:not(:empty)');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
            }
            
            return false;
        }
        
        // Show loading state
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<span>Đang đăng ký...</span>';
    });
    
    // Validation functions
    function validateEmail() {
        const email = emailInput.value.trim();
        
        if (!email) {
            setError(emailInput, emailError, 'Vui lòng nhập email');
            return false;
        }
        
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            setError(emailInput, emailError, 'Email không hợp lệ');
            return false;
        }
        
        clearError(emailInput, emailError);
        return true;
    }
    
    function validateFullName() {
        const fullName = fullNameInput.value.trim();
        
        if (!fullName) {
            setError(fullNameInput, fullNameError, 'Vui lòng nhập họ và tên');
            return false;
        }
        
        if (fullName.length < 2) {
            setError(fullNameInput, fullNameError, 'Họ và tên phải có ít nhất 2 ký tự');
            return false;
        }
        
        if (fullName.length > 100) {
            setError(fullNameInput, fullNameError, 'Họ và tên không được quá 100 ký tự');
            return false;
        }
        
        clearError(fullNameInput, fullNameError);
        return true;
    }
    
    function validatePassword() {
        const password = passwordInput.value;
        
        if (!password) {
            setError(passwordInput, passwordError, 'Vui lòng nhập mật khẩu');
            return false;
        }
        
        if (password.length < 8) {
            setError(passwordInput, passwordError, 'Mật khẩu phải có ít nhất 8 ký tự');
            return false;
        }
        
        // Check password strength
        const hasUpperCase = /[A-Z]/.test(password);
        const hasLowerCase = /[a-z]/.test(password);
        const hasNumber = /[0-9]/.test(password);
        
        if (!hasUpperCase || !hasLowerCase || !hasNumber) {
            setError(passwordInput, passwordError, 'Mật khẩu phải có chữ hoa, chữ thường và số');
            return false;
        }
        
        clearError(passwordInput, passwordError);
        return true;
    }
    
    function validateConfirmPassword() {
        const password = passwordInput.value;
        const confirmPassword = confirmPasswordInput.value;
        
        if (!confirmPassword) {
            setError(confirmPasswordInput, confirmPasswordError, 'Vui lòng xác nhận mật khẩu');
            return false;
        }
        
        if (password !== confirmPassword) {
            setError(confirmPasswordInput, confirmPasswordError, 'Mật khẩu xác nhận không khớp');
            return false;
        }
        
        clearError(confirmPasswordInput, confirmPasswordError);
        return true;
    }
    
    // Password strength calculation
    function calculatePasswordStrength(password) {
        let strength = 0;
        
        // Length
        if (password.length >= 8) strength += 25;
        if (password.length >= 12) strength += 25;
        
        // Contains lowercase
        if (/[a-z]/.test(password)) strength += 15;
        
        // Contains uppercase
        if (/[A-Z]/.test(password)) strength += 15;
        
        // Contains numbers
        if (/[0-9]/.test(password)) strength += 15;
        
        // Contains special characters
        if (/[^a-zA-Z0-9]/.test(password)) strength += 15;
        
        return Math.min(strength, 100);
    }
    
    function updateStrengthUI(strength) {
        strengthBar.style.width = strength + '%';
        
        let label, color;
        
        if (strength < 40) {
            label = 'Yếu';
            color = '#dc2626'; // red
        } else if (strength < 70) {
            label = 'Trung bình';
            color = '#f59e0b'; // yellow
        } else if (strength < 90) {
            label = 'Mạnh';
            color = '#10b981'; // green
        } else {
            label = 'Rất mạnh';
            color = '#059669'; // dark green
        }
        
        strengthBar.style.backgroundColor = color;
        strengthText.textContent = label;
        strengthText.style.color = color;
    }
    
    // Password toggle helper
    function setupPasswordToggle(inputId, toggleId) {
        const input = document.getElementById(inputId);
        const toggle = document.getElementById(toggleId);
        const eyeOpen = toggle.querySelector('.eye-open');
        const eyeClosed = toggle.querySelector('.eye-closed');
        
        toggle.addEventListener('click', function() {
            if (input.type === 'password') {
                input.type = 'text';
                eyeOpen.style.display = 'none';
                eyeClosed.style.display = 'block';
                toggle.setAttribute('aria-label', 'Hide password');
            } else {
                input.type = 'password';
                eyeOpen.style.display = 'block';
                eyeClosed.style.display = 'none';
                toggle.setAttribute('aria-label', 'Show password');
            }
        });
    }
    
    // Error handling helpers
    function setError(input, errorElement, message) {
        input.style.borderColor = '#dc2626';
        errorElement.textContent = message;
    }
    
    function clearError(input, errorElement) {
        input.style.borderColor = '#e5e7eb';
        errorElement.textContent = '';
    }
    
    function clearAllErrors() {
        emailError.textContent = '';
        fullNameError.textContent = '';
        passwordError.textContent = '';
        confirmPasswordError.textContent = '';
        
        emailInput.style.borderColor = '#e5e7eb';
        fullNameInput.style.borderColor = '#e5e7eb';
        passwordInput.style.borderColor = '#e5e7eb';
        confirmPasswordInput.style.borderColor = '#e5e7eb';
    }
    
    // Auto-hide messages
    const errorMessage = document.getElementById('errorMessage');
    const successMessage = document.getElementById('successMessage');
    
    if (errorMessage) {
        setTimeout(function() {
            errorMessage.style.opacity = '0';
            setTimeout(() => errorMessage.style.display = 'none', 300);
        }, 5000);
    }
    
    if (successMessage) {
        setTimeout(function() {
            successMessage.style.opacity = '0';
            setTimeout(() => successMessage.style.display = 'none', 300);
        }, 5000);
    }
});

