/**
 * Autocomplete functionality for search inputs
 * @author PRJ301
 */

(function() {
    'use strict';
    
    // Configuration
    const CONFIG = {
        minLength: 2,           // Minimum characters before search
        debounceDelay: 300,     // ms to wait after typing
        maxResults: 8,          // Maximum suggestions to show
        apiEndpoint: '/Dictionary-persionaly/api/search-suggestions'
    };
    
    // Debounce function
    function debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }
    
    // Initialize autocomplete on a search input
    function initAutocomplete(inputElement) {
        if (!inputElement) return;
        
        // Create dropdown container
        const dropdown = document.createElement('div');
        dropdown.className = 'autocomplete-dropdown';
        dropdown.style.display = 'none';
        inputElement.parentNode.style.position = 'relative';
        inputElement.parentNode.appendChild(dropdown);
        
        let currentFocus = -1;
        
        // Fetch suggestions from API
        async function fetchSuggestions(query) {
            try {
                const response = await fetch(`${CONFIG.apiEndpoint}?q=${encodeURIComponent(query)}`);
                if (!response.ok) throw new Error('Network response was not ok');
                const data = await response.json();
                return data;
            } catch (error) {
                console.error('Error fetching suggestions:', error);
                return [];
            }
        }
        
        // Display suggestions
        function displaySuggestions(suggestions) {
            dropdown.innerHTML = '';
            currentFocus = -1;
            
            if (suggestions.length === 0) {
                dropdown.style.display = 'none';
                return;
            }
            
            suggestions.forEach((item, index) => {
                const div = document.createElement('div');
                div.className = 'autocomplete-item';
                div.setAttribute('data-index', index);
                
                // Build HTML for suggestion item
                div.innerHTML = `
                    <div class="autocomplete-word">
                        <strong>${item.word_english}</strong>
                        ${item.pronunciation ? `<span class="autocomplete-pronunciation">${item.pronunciation}</span>` : ''}
                    </div>
                    <div class="autocomplete-meaning">
                        ${item.word_vietnamese}
                        ${item.word_type ? `<span class="autocomplete-type">(${item.word_type})</span>` : ''}
                    </div>
                `;
                
                // Click handler
                div.addEventListener('click', function() {
                    inputElement.value = item.word_english;
                    dropdown.style.display = 'none';
                    inputElement.form.submit();
                });
                
                // Hover handler
                div.addEventListener('mouseenter', function() {
                    removeActive();
                    div.classList.add('autocomplete-active');
                    currentFocus = index;
                });
                
                dropdown.appendChild(div);
            });
            
            dropdown.style.display = 'block';
        }
        
        // Remove active class from all items
        function removeActive() {
            const items = dropdown.getElementsByClassName('autocomplete-item');
            for (let i = 0; i < items.length; i++) {
                items[i].classList.remove('autocomplete-active');
            }
        }
        
        // Add active class to item
        function addActive(index) {
            const items = dropdown.getElementsByClassName('autocomplete-item');
            if (!items) return false;
            removeActive();
            if (index >= items.length) index = 0;
            if (index < 0) index = items.length - 1;
            items[index].classList.add('autocomplete-active');
            currentFocus = index;
        }
        
        // Handle input
        const handleInput = debounce(async function(e) {
            const value = e.target.value.trim();
            
            if (value.length < CONFIG.minLength) {
                dropdown.style.display = 'none';
                return;
            }
            
            const suggestions = await fetchSuggestions(value);
            displaySuggestions(suggestions);
        }, CONFIG.debounceDelay);
        
        // Event listeners
        inputElement.addEventListener('input', handleInput);
        
        inputElement.addEventListener('keydown', function(e) {
            const items = dropdown.getElementsByClassName('autocomplete-item');
            
            if (e.keyCode === 40) { // Arrow DOWN
                e.preventDefault();
                currentFocus++;
                addActive(currentFocus);
            } else if (e.keyCode === 38) { // Arrow UP
                e.preventDefault();
                currentFocus--;
                addActive(currentFocus);
            } else if (e.keyCode === 13) { // ENTER
                if (currentFocus > -1 && items[currentFocus]) {
                    e.preventDefault();
                    items[currentFocus].click();
                }
            } else if (e.keyCode === 27) { // ESC
                dropdown.style.display = 'none';
            }
        });
        
        // Close dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if (e.target !== inputElement) {
                dropdown.style.display = 'none';
            }
        });
        
        // Reopen dropdown on focus if there's text
        inputElement.addEventListener('focus', function() {
            if (this.value.trim().length >= CONFIG.minLength) {
                fetchSuggestions(this.value.trim()).then(displaySuggestions);
            }
        });
    }
    
    // Auto-initialize on page load
    document.addEventListener('DOMContentLoaded', function() {
        // Find all search inputs with data-autocomplete attribute
        const searchInputs = document.querySelectorAll('input[data-autocomplete="true"]');
        searchInputs.forEach(input => initAutocomplete(input));
        
        // Fallback: Initialize on common search input classes/names
        if (searchInputs.length === 0) {
            const fallbackInputs = document.querySelectorAll('.search-input, input[name="keyword"]');
            fallbackInputs.forEach(input => initAutocomplete(input));
        }
    });
    
    // Export for manual initialization
    window.initAutocomplete = initAutocomplete;
})();

