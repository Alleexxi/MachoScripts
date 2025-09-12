// Modular recursive menu system
class MenuItem {
    constructor(label, type = 'action', options = {}) {
        this.label = label;
        this.type = type; // 'action', 'toggle', 'slider', 'options', 'label'
        this.value = options.value || false;
        this.callback = options.callback || null;
        this.options = options.options || null;
        this.index = options.index || 0;
        this.min = options.min;
        this.max = options.max;
        this.step = options.step || 1;
        this.value = (type === 'slider') ? (options.value !== undefined ? options.value : options.min) : this.value;
        this.id = options.id || null;
        this.className = options.className || null;
    }
    left() {
        if (this.type === 'slider') {
            this.value = Math.max(this.min, this.value - this.step);
            if (this.callback) this.callback(this.value);
        } else if (this.type === 'options') {
            this.index = (this.index - 1 + this.options.length) % this.options.length;
        }
    }
    right() {
        if (this.type === 'slider') {
            this.value = Math.min(this.max, this.value + this.step);
            if (this.callback) this.callback(this.value);
        } else if (this.type === 'options') {
            this.index = (this.index + 1) % this.options.length;
        }
    }
}

class MenuCategory {
    constructor(name, parent = null) {
        this.name = name;
        this.items = [];
        this.subCategories = [];
        this.parent = parent;
        this.id = null;
        this.className = null;
        if (!parent && typeof window !== 'undefined' && window.mainMenu) {
            window.mainMenu.addSubCategory(this);
        }
    }
    addItem(item) {
        this.items.push(item);
    }
    removeItem(item) {
        this.items = this.items.filter(i => i !== item);
    }
    addSubCategory(subCat) {
        subCat.parent = this;
        this.subCategories.push(subCat);
        if (typeof window !== 'undefined' && window.mainMenu && window.mainMenu.subCategories.includes(subCat) && this !== window.mainMenu) {
            window.mainMenu.subCategories = window.mainMenu.subCategories.filter(c => c !== subCat);
        }
    }
    removeItemsById(id) {
        this.items = this.items.filter(i => i.id !== id);
        moveSelectionToNearest(this);
        if (typeof window.renderMenu === 'function') window.renderMenu();
    }
    removeItemsByClass(className) {
        this.items = this.items.filter(i => i.className !== className);
        moveSelectionToNearest(this);
        if (typeof window.renderMenu === 'function') window.renderMenu();
    }
}



// Menu state
window.mainMenu = new MenuCategory('Main Menu');
let mainMenu = window.mainMenu;
let currentMenu = mainMenu;
let selectedIndex = 0;
let inMainMenu = true;

// DOM
const menuList = document.getElementById('menuList');
const menuTitle = document.querySelector('.menu-title');

// Rendering
function renderMenu() {
    // Calculate entries
    let entries = [];
    if (inMainMenu) {
        entries = mainMenu.subCategories;
        if (entries.length === 0) {
            const div = document.createElement('div');
            div.className = 'menu-item selected';
            div.textContent = 'No categories';
            menuList.innerHTML = '';
            menuList.appendChild(div);
            menuTitle.textContent = `${currentMenu.name} (0, 0)`;
            return;
        }
    } else {
        entries = [];
        currentMenu.items.forEach(item => {
            if (item.type === 'container') {
                entries.push(...item.items); // Only render items inside container
            } else {
                entries.push(item);
            }
        });
        entries.push(...currentMenu.subCategories);
        entries.unshift({ label: '< Back', type: 'back' });
    }
    // Scrolling logic
    const maxVisible = 10;
    let start = 0;
    if (entries.length > maxVisible) {
        if (selectedIndex < maxVisible) {
            start = 0;
        } else {
            start = selectedIndex - (maxVisible - 1);
            if (start < 0) start = 0;
        }
    }
    let end = Math.min(entries.length, start + maxVisible);
    // Menu title with index/count
    let displayIndex = Math.min(selectedIndex + 1, entries.length);
    menuTitle.textContent = `${currentMenu.name} (${displayIndex}, ${entries.length})`;
    menuList.innerHTML = '';
    for (let i = start; i < end; i++) {
        const entry = entries[i];
        let className = 'menu-item';
        if (i === selectedIndex) className += ' selected';
        const div = document.createElement('div');
        if (!inMainMenu && entry.type === 'back') className += ' menu-item-back';
        div.className = className;
        // Create left and right spans
        const leftSpan = document.createElement('span');
        leftSpan.className = 'menu-item-left';
        const rightSpan = document.createElement('span');
        rightSpan.className = 'menu-item-right';
        // Title on left
        if (entry.type === 'label') {
            leftSpan.textContent = entry.label;
            rightSpan.textContent = '';
            div.className += ' menu-item-label';
        } else if (entry.type === 'toggle') {
            leftSpan.textContent = entry.label;
            // Modern switch
            const switchLabel = document.createElement('label');
            switchLabel.className = 'menu-switch';
            const switchInput = document.createElement('input');
            switchInput.type = 'checkbox';
            switchInput.checked = entry.value;
            switchInput.onchange = (e) => {
                entry.value = e.target.checked;
                if (entry.callback) entry.callback(entry.value);
            };
            const switchSlider = document.createElement('span');
            switchSlider.className = 'menu-switch-slider';
            switchLabel.appendChild(switchInput);
            switchLabel.appendChild(switchSlider);
            rightSpan.appendChild(switchLabel);
        } else if (entry.type === 'slider') {
            leftSpan.textContent = entry.label;
            // Flex container for slider and value
            const sliderContainer = document.createElement('span');
            sliderContainer.className = 'menu-slider-container';
            const slider = document.createElement('input');
            slider.type = 'range';
            slider.min = entry.min;
            slider.max = entry.max;
            slider.value = entry.value;
            slider.step = entry.step || 1;
            slider.className = 'menu-slider';
            slider.oninput = (e) => {
                entry.value = Number(e.target.value);
                if (entry.callback) entry.callback(entry.value);
                valueSpan.textContent = entry.value;
            };
            const valueSpan = document.createElement('span');
            valueSpan.textContent = entry.value;
            valueSpan.className = 'menu-slider-value';
            sliderContainer.appendChild(slider);
            sliderContainer.appendChild(valueSpan);
            rightSpan.appendChild(sliderContainer);
        } else if (entry.type === 'options') {
            leftSpan.textContent = entry.label;
            // Modern options: < value > with arrows
            const optionsContainer = document.createElement('span');
            optionsContainer.className = 'menu-options-container';
            // Left arrow
            const leftArrow = document.createElement('span');
            leftArrow.className = 'menu-options-arrow';
            leftArrow.textContent = '<';
            leftArrow.style.cursor = 'pointer';
            leftArrow.onclick = (e) => {
                e.stopPropagation();
                entry.left();
                if (entry.callback) entry.callback(entry.options[entry.index], entry.index);
                renderMenu();
            };
            // Value
            const valueSpan = document.createElement('span');
            valueSpan.className = 'menu-options-value';
            valueSpan.textContent = entry.options[entry.index];
            // Right arrow
            const rightArrow = document.createElement('span');
            rightArrow.className = 'menu-options-arrow';
            rightArrow.textContent = '>';
            rightArrow.style.cursor = 'pointer';
            rightArrow.onclick = (e) => {
                e.stopPropagation();
                entry.right();
                if (entry.callback) entry.callback(entry.options[entry.index], entry.index);
                renderMenu();
            };
            optionsContainer.appendChild(leftArrow);
            optionsContainer.appendChild(valueSpan);
            optionsContainer.appendChild(rightArrow);
            rightSpan.appendChild(optionsContainer);
        } else if (entry instanceof MenuCategory) {
            leftSpan.textContent = entry.name;
            rightSpan.textContent = '';
        } else if (entry.type === 'back') {
            leftSpan.textContent = entry.label;
            rightSpan.textContent = '';
            div.className += ' menu-item-back';
        } else {
            leftSpan.textContent = entry.label;
            rightSpan.textContent = '';
        }
        leftSpan.style.float = 'left';
        rightSpan.style.float = 'right';
        div.appendChild(leftSpan);
        div.appendChild(rightSpan);
        div.onclick = () => {
            selectedIndex = i;
            handleEnter();
            renderMenu();
        };
        menuList.appendChild(div);
    }
}

let popupDiv = document.createElement('div');
popupDiv.id = 'menu-popup';
popupDiv.className = 'menu-popup';
popupDiv.style.display = 'none';
document.body.appendChild(popupDiv);

let popupTitleDiv = document.createElement('div');
popupTitleDiv.className = 'menu-popup-title';
let popupTextDiv = document.createElement('div');
popupTextDiv.className = 'menu-popup-text';

popupDiv.appendChild(popupTitleDiv);
popupDiv.appendChild(popupTextDiv);

function enablePopup(title = '', text = '') {
    popupDiv.style.display = 'flex';
    popupDiv.className = 'menu-popup';
    popupTitleDiv.textContent = title;
    popupTextDiv.textContent = text;
}

function updatePopup(title = '', text = '') {
    popupTitleDiv.textContent = title;
    popupTextDiv.textContent = text;
}

function disablePopup() {
    popupDiv.style.display = 'none';
    popupDiv.className = 'menu-popup';
    popupTitleDiv.textContent = '';
    popupTextDiv.textContent = '';
}
window.addEventListener("message", function (event) {
    // Log for debugging
    console.log("DUI message received:", event.data);
    if (!event.data || !event.data.event) return;

    if (event.data.event === "popup") {
        const args = event.data.args || {};
        if (!args.enabled) {
            disablePopup();
        } else {
            enablePopup(args.title, args.text);
        }
    } else if (event.data.event === "popup_update") {
        const args = event.data.args || {};
        updatePopup(args.title, args.text);
    }
    if (event.data.event === "menu") {
        // Example data: {Menu: {...}, index: ...}
        const menuData = event.data.args.Menu;
        const selectedIndex = event.data.args.index || 1;
        // DOM elements
        const menuList = document.getElementById('menuList');
        const menuTitle = document.querySelector('.menu-title');
        menuList.innerHTML = '';
        let entries = menuData.entries || [];
        const maxVisible = 10;
        let start = 0;
        if (entries.length > maxVisible) {
            if (selectedIndex <= maxVisible) {
                start = 0;
            } else {
                start = selectedIndex - maxVisible;
                if (start < 0) start = 0;
            }
        }
        let end = Math.min(entries.length, start + maxVisible);
        // Set menu title with index/maxindex
        menuTitle.textContent = `${menuData.name || ''} (${selectedIndex}, ${entries.length})`;
        for (let i = start; i < end; i++) {
            const entry = entries[i];
            let className = 'menu-item';
            if (i + 1 === selectedIndex) className += ' selected'; // Lua is 1-based
            const div = document.createElement('div');
            div.className = className;
            // Left/right spans
            const leftSpan = document.createElement('span');
            leftSpan.className = 'menu-item-left';
            const rightSpan = document.createElement('span');
            rightSpan.className = 'menu-item-right';
            leftSpan.textContent = entry.name || '';
            // Show submenu indicator for type 'menu'
            if (entry.type === 'menu') {
                rightSpan.textContent = '>';
            }
            // Render options type
            if (entry.type === 'options' && Array.isArray(entry.options)) {
                // Modern options: < value > with arrows
                const optionsContainer = document.createElement('span');
                optionsContainer.className = 'menu-options-container';
                // Left arrow
                const leftArrow = document.createElement('span');
                leftArrow.className = 'menu-options-arrow';
                leftArrow.textContent = '<';
                leftArrow.style.cursor = 'pointer';
                leftArrow.onclick = (e) => {
                    e.stopPropagation();
                    // Send message to Lua to decrement index
                    window.postMessage({ event: "options_left", args: { entryIndex: i } }, "*");
                };
                // Value
                const valueSpan = document.createElement('span');
                valueSpan.className = 'menu-options-value';
                // Lua is 1-based, JS is 0-based
                let optIndex = (entry.index || 1) - 1;
                valueSpan.textContent = entry.options[optIndex] || '';
                // Right arrow
                const rightArrow = document.createElement('span');
                rightArrow.className = 'menu-options-arrow';
                rightArrow.textContent = '>';
                rightArrow.style.cursor = 'pointer';
                rightArrow.onclick = (e) => {
                    e.stopPropagation();
                    // Send message to Lua to increment index
                    window.postMessage({ event: "options_right", args: { entryIndex: i } }, "*");
                };
                optionsContainer.appendChild(leftArrow);
                optionsContainer.appendChild(valueSpan);
                optionsContainer.appendChild(rightArrow);
                rightSpan.appendChild(optionsContainer);
            }
            // Render toggle type
            if (entry.type === 'toggle') {
                // Modern switch
                const switchLabel = document.createElement('label');
                switchLabel.className = 'menu-switch';
                const switchInput = document.createElement('input');
                switchInput.type = 'checkbox';
                switchInput.checked = !!entry.value;
                switchInput.onchange = (e) => {
                    // Send message to Lua to toggle value
                    window.postMessage({ event: "toggle_changed", args: { entryIndex: i, value: e.target.checked } }, "*");
                };
                const switchSlider = document.createElement('span');
                switchSlider.className = 'menu-switch-slider';
                switchLabel.appendChild(switchInput);
                switchLabel.appendChild(switchSlider);
                rightSpan.appendChild(switchLabel);
            }
            // Render slider type
            if (entry.type === 'slider' && entry.settings) {
                const sliderContainer = document.createElement('span');
                sliderContainer.className = 'menu-slider-container';
                const slider = document.createElement('input');
                slider.type = 'range';
                slider.min = entry.settings.min;
                slider.max = entry.settings.max;
                slider.step = entry.settings.step || 1;
                slider.value = entry.value;
                slider.className = 'menu-slider';
                const valueSpan = document.createElement('span');
                valueSpan.textContent = entry.value;
                valueSpan.className = 'menu-slider-value';
                slider.oninput = (e) => {
                    valueSpan.textContent = e.target.value;
                    // Send message to Lua to update slider value
                    window.postMessage({ event: "slider_changed", args: { entryIndex: i, value: Number(e.target.value) } }, "*");
                };
                sliderContainer.appendChild(slider);
                sliderContainer.appendChild(valueSpan);
                rightSpan.appendChild(sliderContainer);
            }
            leftSpan.style.float = 'left';
            rightSpan.style.float = 'right';
            div.appendChild(leftSpan);
            div.appendChild(rightSpan);
            menuList.appendChild(div);
        }
    } else if (event.data.event === "popup") {
        showPopup(event.data.args || {});
    }
});

renderMenu();
