document.addEventListener('DOMContentLoaded', function () {
    const toggleButtons = document.querySelectorAll('.toggle-button');
    const noteFormContainer = document.getElementById('note-form-container');
    const addNoteButton = document.getElementById('add-note-button');
    const saveNoteButton = document.getElementById('save-note');
    const addFriendButton = document.getElementById('add-friend');
    const sharedWithContainer = document.getElementById('shared-with');
    const noteTitle = document.getElementById('note-title');
    const noteContent = document.getElementById('note-content');
    const noteModalContainer = document.getElementById('note-modal-container');
    const modalNoteTitle = document.getElementById('modal-note-title');
    const modalNoteContent = document.getElementById('modal-note-content');
    const editNoteButton = document.getElementById('edit-note');
    const modalSharedWithContainer = document.getElementById('modal-shared-with');
    const maxFriends = 3; // Maksymalna liczba wyświetlanych znajomych
    let friends = [];
    let friendCounter = 1; // Licznik znajomych
    let editingNoteIndex = -1; // Indeks edytowanej notatki
    const notes = [];

    toggleButtons.forEach(button => {
        button.addEventListener('click', function () {
            const icon = this.querySelector('.material-symbols-outlined');
            const sectionId = this.getAttribute('data-section');
            const section = document.getElementById(sectionId);

            if (section.style.display === 'none') {
                section.style.display = 'flex';
                icon.textContent = 'hide';
            } else {
                section.style.display = 'none';
                icon.textContent = 'unfold_more';
            }
        });
    });

    addNoteButton.addEventListener('click', function () {
        editingNoteIndex = -1; // Resetowanie indeksu edytowanej notatki
        friends = [];
        updateSharedWith();
        noteFormContainer.style.display = 'flex';
    });

    saveNoteButton.addEventListener('click', function () {
        const title = noteTitle.value.trim();
        const content = noteContent.value.trim();

        if (title === '' && content === '') {
            alert('Nie można dodać pustej notatki');
            return;
        }

        if (editingNoteIndex === -1) {
            const noteIndex = notes.length;
            const noteCard = document.createElement('div');
            noteCard.className = 'note-card';
            noteCard.setAttribute('data-index', noteIndex);
            noteCard.innerHTML = `
                <h3>${title}</h3>
                <p>${content}</p>
            `;
            noteCard.addEventListener('click', function () {
                showNoteModal(noteCard, noteIndex);
            });

            document.getElementById('my-notes').appendChild(noteCard);
            notes.push({ title, content, friends: [...friends] });
        } else {
            const noteCards = document.querySelectorAll('.note-card');
            const noteCard = noteCards[editingNoteIndex];
            noteCard.querySelector('h3').textContent = title;
            noteCard.querySelector('p').textContent = content;
            notes[editingNoteIndex] = { title, content, friends: [...friends] };
        }

        noteTitle.value = '';
        noteContent.value = '';
        sharedWithContainer.innerHTML = '';
        friends = [];
        noteFormContainer.style.display = 'none';
    });

    noteFormContainer.addEventListener('click', function (event) {
        if (event.target === noteFormContainer) {
            noteFormContainer.style.display = 'none';
        }
    });

    addFriendButton.addEventListener('click', function () {
        const newFriend = {
            id: friendCounter++,
            name: `Znajomy ${friendCounter - 1}`,
            img: '/public/img/profile.jpg'
        };

        if (friends.length >= maxFriends) {
            friends.shift();
        }
        friends.push(newFriend);

        updateSharedWith();
    });

    function updateSharedWith() {
        sharedWithContainer.innerHTML = '';
        friends.forEach(friend => {
            const friendDiv = document.createElement('div');
            friendDiv.className = 'friend';
            friendDiv.innerHTML = `
                <img src="${friend.img}" alt="${friend.name}" class="friend-icon">
                <span>${friend.name}</span>
                <img src="/public/img/minus.svg" alt="Usuń" class="remove-icon" data-id="${friend.id}">
            `;
            sharedWithContainer.appendChild(friendDiv);
        });

        document.querySelectorAll('.remove-icon').forEach(icon => {
            icon.addEventListener('click', function () {
                const id = parseInt(this.getAttribute('data-id'));
                friends = friends.filter(friend => friend.id !== id);
                updateSharedWith();
            });
        });
    }

    function showNoteModal(noteCard, index) {
        const note = notes[index] || {
            title: noteCard.querySelector('h3').textContent,
            content: noteCard.querySelector('p').textContent,
            friends: []
        };
        modalNoteTitle.textContent = note.title;
        modalNoteContent.textContent = note.content;
        friends = [...note.friends];
        updateSharedWithModal();
        editingNoteIndex = index; // Ustawianie indeksu edytowanej notatki
        noteModalContainer.style.display = 'flex';
    }

    function updateSharedWithModal() {
        modalSharedWithContainer.innerHTML = '';
        friends.forEach(friend => {
            const friendDiv = document.createElement('div');
            friendDiv.className = 'friend';
            friendDiv.innerHTML = `
                <img src="${friend.img}" alt="${friend.name}" class="friend-icon">
                <span>${friend.name}</span>
            `;
            modalSharedWithContainer.appendChild(friendDiv);
        });
    }

    noteModalContainer.addEventListener('click', function (event) {
        if (event.target === noteModalContainer) {
            noteModalContainer.style.display = 'none';
        }
    });

    editNoteButton.addEventListener('click', function () {
        noteTitle.value = modalNoteTitle.textContent;
        noteContent.value = modalNoteContent.textContent;
        updateSharedWith();
        noteModalContainer.style.display = 'none';
        noteFormContainer.style.display = 'flex';
    });

    // Dodaj nasłuchiwanie na istniejące notatki
    document.querySelectorAll('.note-card').forEach((noteCard, index) => {
        noteCard.addEventListener('click', function () {
            showNoteModal(noteCard, index);
        });
    });
});
