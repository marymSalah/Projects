// basics of running the program 
document.addEventListener('keydown', (event) => {
    if (!isMoving) {
        currentDirection = event.key; // Set the current direction
        movePacman(currentDirection); // Move once immediately
        moveInterval = setInterval(() => movePacman(currentDirection), 200); // Move continuously
        isMoving = true;
    }
});

document.addEventListener('keyup', () => {
    if (isPaused) {
        return;
    }
    clearInterval(moveInterval); // Stop moving when the key is released
    isMoving = false;
});

requestAnimationFrame(() => createLevel(level))
requestAnimationFrame(updateFPS); // Call updateFPS function


// level specified
function createLevel(level) {
    if (level == 1) {
        lives = 3
        levelDisplay.innerHTML = level
        createBoard(layout1)
        pacmanCurrentIndex = 490
        squares[pacmanCurrentIndex].classList.add('pacman')
        createGhosts(level)
        ghosts.forEach(ghost => {
            squares[ghost.currentIndex].classList.add(ghost.className)
            squares[ghost.currentIndex].classList.add('ghost')  
        })
        ghosts.forEach(ghost => moveGhost(ghost) )
        startTimer(level)
    } else if (level == 2) {
        clearLevel()
        document.addEventListener('keyup', movePacman)  
        createGhosts(level)
        createBoard(layout2)
        pacmanCurrentIndex = 490
        squares[pacmanCurrentIndex].classList.add('pacman')
        ghosts.forEach(ghost => {
            squares[ghost.currentIndex].classList.add(ghost.className)
            squares[ghost.currentIndex].classList.add('ghost')
        })
        ghosts.forEach(ghost => moveGhost(ghost) )
        startTimer(level)
    }
}

function updateFPS(timestamp) {
    // Calculate FPS
    if (lastTime) {
        const delta = (timestamp - lastTime) / 1000;
        fps = Math.round(1 / delta);
        fpsDisplay.textContent = `FPS: ${fps}`;
        let count = 0
    }
    lastTime = timestamp;
    requestAnimationFrame(updateFPS);
}

// create the grid
function createBoard(layout) {
    livesDisplay.innerHTML = lives
    for (let i = 0; i < layout.length; i++) {
        const square = document.createElement('div')
        square.id = i
        gameBoard.appendChild(square)
        squares.push(square)

        // add layout to the grid
        if (layout[i] === 0) {
            squares[i].classList.add('pac-dot')
        } else if (layout[i] === 1) {
            squares[i].classList.add('wall')
        } else if (layout[i] === 2) {
            squares[i].classList.add('ghost-lair')
        } else if (layout[i] === 3) {
            squares[i].classList.add('power-pellet')
        }
    }
}

// -------------------------- create the characters -------------------------------------------------
function movePacman(direction) {
    squares[pacmanCurrentIndex].classList.remove('pacman');
    switch (direction) {
        case 'ArrowLeft':
            if (pacmanCurrentIndex % width !== 0
                && !squares[pacmanCurrentIndex - 1].classList.contains('wall')
                && !squares[pacmanCurrentIndex - 1].classList.contains('ghost-lair')) {
                pacmanCurrentIndex -= 1;
            }
            break;
        case 'ArrowUp':
            if (pacmanCurrentIndex - width >= 0
                && !squares[pacmanCurrentIndex - width].classList.contains('wall')
                && !squares[pacmanCurrentIndex - width].classList.contains('ghost-lair')) {
                pacmanCurrentIndex -= width;
            }
            break;
        case 'ArrowRight':
            if (pacmanCurrentIndex % width < width - 1
                && !squares[pacmanCurrentIndex + 1].classList.contains('wall')
                && !squares[pacmanCurrentIndex + 1].classList.contains('ghost-lair')) {
                pacmanCurrentIndex += 1;
            }
            break;
        case 'ArrowDown':
            if (pacmanCurrentIndex + width < width * width
                && !squares[pacmanCurrentIndex + width].classList.contains('wall')
                && !squares[pacmanCurrentIndex + width].classList.contains('ghost-lair')) {
                pacmanCurrentIndex += width;
            }
            break;
        case 'p':
            // Pause the game
            pauseGame();
            break;
    }

    squares[pacmanCurrentIndex].classList.add('pacman');
    
    // Call other game functions
    pacDotEaten();
    powerPelletEaten();
    checkForGameOver();
    checkForWin();
}

// what happens when pacman eats a dot
function pacDotEaten() {
    if (squares[pacmanCurrentIndex].classList.contains('pac-dot') ) {
            score ++
            scoreDisplay.innerHTML = score
            squares[pacmanCurrentIndex].classList.remove('pac-dot')
            playAudio('static/audio/pacmanEat.mp3')
        }
}

function powerPelletEaten() {
    if (squares[pacmanCurrentIndex].classList.contains('power-pellet')) {
        score += 10
        scoreDisplay.innerHTML = score
        ghosts.forEach(ghost => {
            ghost.isScared = true
        })
        setTimeout(unScareGhosts, 10000)
        squares[pacmanCurrentIndex].classList.remove('power-pellet')
    }
}

// make the ghosts stop flashing 
function unScareGhosts() {
    ghosts.forEach(ghost => ghost.isScared = false)
}

function createGhosts(level) {
    // all ghosts
    if (level == 1) {
        ghosts = [
            // two ghosts
            new Ghost ('pinky', 376, 400),
            new Ghost ('clyde', 379, 500)
        ]
    } else if (level == 2) {
        ghosts = [
            // three ghosts
            new Ghost('blinky', 379, 250), 
            new Ghost('pinky', 377, 400),
            new Ghost('inky', 406, 300),
            // new Ghost('clyde', 405, 500)
        ];
    }
}

function moveGhost(ghost) {
    const directions = [-1, 1, width, -width];
    let direction = directions[Math.floor(Math.random() * directions.length)];
    let pacdotIndex = 0;

    ghost.timerId = setInterval(function() {
        // Check if the game is paused
        if (isPaused) {
            return; // Stop the ghost from moving
        }

        // If next square is not a wall and not a ghost
        if (
            !squares[ghost.currentIndex + direction].classList.contains('wall') &&
            !squares[ghost.currentIndex + direction].classList.contains('ghost')
        ) {
            // Restore pac-dot if necessary
            if (pacdotIndex !== 0) {
                squares[pacdotIndex].classList.add('pac-dot');
            }

            // Remove ghost from current position
            squares[ghost.currentIndex].classList.remove(ghost.className, 'ghost', 'scared-ghost');

            // Check if the next position has a pac-dot
            if (squares[ghost.currentIndex + direction].classList.contains('pac-dot')) {
                pacdotIndex = ghost.currentIndex + direction;
                squares[ghost.currentIndex + direction].classList.remove('pac-dot');
            }

            // Move ghost to new position
            ghost.currentIndex += direction;

            // Add ghost to new position
            squares[ghost.currentIndex].classList.add(ghost.className, 'ghost');

            // If the ghost is scared, add the scared-ghost class
            if (ghost.isScared) {
                squares[ghost.currentIndex].classList.add('scared-ghost');
            }
        } else {
            // Find a new random direction to go in
            direction = directions[Math.floor(Math.random() * directions.length)];
        }

        // If the ghost is scared and Pac-Man is on it
        if (ghost.isScared && squares[ghost.currentIndex].classList.contains('pacman')) {
            squares[ghost.currentIndex].classList.remove(ghost.className, 'ghost', 'scared-ghost');
            ghost.currentIndex = ghost.startIndex;
            score += 100;
            scoreDisplay.innerHTML = score;
            squares[ghost.currentIndex].classList.add(ghost.className, 'ghost');
        }

        checkForGameOver();

    }, ghost.speed);
}

function checkForGameOver() {
    if (timer.textContent === '00:00') {
        ghosts.forEach(ghost => clearInterval(ghost.timerId));
        document.removeEventListener('keyup', movePacman);
        // setTimeout(function() {alert('Game Over')}, 500);
        if (confirm(`Game Over! Your final score is ${score} \n Play Again?`)) {
            location.reload();
        } else {
            pauseGame();
        }
        return;
    }
    
    if (
        squares[pacmanCurrentIndex].classList.contains('ghost') &&
        !squares[pacmanCurrentIndex].classList.contains('scared-ghost')
    ) {
        lives--;
        livesDisplay.innerHTML = lives;
            if (lives > 0) {
                // Reset Pac-Man and ghosts positions
                alert('Life lost... resetting positions')
                resetPositions();
                livesDisplay.innerHTML = lives;
            } else {
                ghosts.forEach(ghost => clearInterval(ghost.timerId));
                document.removeEventListener('keyup', movePacman);
                if (confirm(`Game Over! Your final score is ${score} \n Play Again?`)) {
                    location.reload();
                } else {
                    pauseGame();
                }
            }
    }
}

function checkForWin() {
    // check if all the pac-dots and power-pellets have been eaten 
    if (squares.filter(square => square.classList.contains('pac-dot') || square.classList.contains('power-pellet')).length === 0) {
        ghosts.forEach(ghost => clearInterval(ghost.timerId));
        document.removeEventListener('keyup', movePacman);
        setTimeout(() => {
            nextLevel(level, lives);
        }, 500);
    }
}

function nextLevel(level, lives) {
    livesDisplay.innerHTML = lives;
    // move to level 2 
    if (level == 1) {
        level++;
        levelDisplay.innerHTML = level;
        livesDisplay.innerHTML = lives;
        createLevel(level);
        alert('Next Level!');
    } else if (level == 2) {
        level++;
        levelDisplay.innerHTML = level;
        livesDisplay.innerHTML = lives;
        createGhosts(level);
        createBoard(layout3);
        alert('Next Level!');
    } else if (level == 3) {
        alert('You Win!');
    }
}

function playAudio(url) {
    let audio = new Audio(url)
    audio.play()
}

// function to clear the ghosts and pacman for next level 
function clearLevel() {
    clearInterval(timerInterval)
    squares.forEach(square => {
        square.classList.remove('pacman', 'ghost', 'scared-ghost','pinky', 'blinky', 'inky', 'clyde', 'wall')
    })
    timer.textContent = 0
}

// -------------------------------- PAUSE MENU -------------------------------------

function pauseGame() {
    isPaused = true;
    document.getElementById('pause-overlay').removeAttribute('hidden');
    document.querySelector('.pause-menu').removeAttribute('hidden');
    clearInterval(moveInterval);  // Clear the movement interval
}
function resumeGame() {
    console.log('resumed')
    isPaused = false;
    document.getElementById('pause-overlay').style.display = 'none';
    document.querySelector('.pause-menu').style.display = 'none';

}

function restartGame() {
    location.reload();
}

// ------------------------------ END OF PAUSE MENU --------------------------------

function resetPositions() {    
    
    clearInterval(moveInterval)
    // Reset Pac-Man position
    squares[pacmanCurrentIndex].classList.remove('pacman');
    pacmanCurrentIndex = 490; // Starting position
    squares[pacmanCurrentIndex].classList.add('pacman');
    clearInterval(moveInterval)

    // Reset ghost positions
    ghosts.forEach(ghost => {
        squares[ghost.currentIndex].classList.remove(ghost.className, 'ghost', 'scared-ghost');
        ghost.currentIndex = ghost.startIndex;
        squares[ghost.currentIndex].classList.add(ghost.className, 'ghost');
    });

    // Restart ghost movement
    ghosts.forEach(ghost => {
        clearInterval(ghost.timerId);
        moveGhost(ghost);
    });
}

// add a 60 seconds timer to the div that is called timer in the html 
function startTimer(level) {
    if (!timer) {
        console.error('Timer element not found');
        return;
    }

    if (level == 1) {
        let seconds = 60;
        timerInterval = setInterval(function() {
            if (isPaused) {
                return;
            }
            if (seconds === 0) {
                clearInterval(timerInterval);
                timer.textContent = "Time's up!";
                checkForGameOver();
                return;
            }
            seconds--;
            
            let displayMinutes = Math.floor(seconds / 60);
            let displaySeconds = seconds % 60;
            displayMinutes = displayMinutes < 10 ? "0" + displayMinutes : displayMinutes;
            displaySeconds = displaySeconds < 10 ? "0" + displaySeconds : displaySeconds;
            // console.log(displayMinutes + ":" + displaySeconds);
            timer.textContent = displayMinutes + ":" + displaySeconds;
        }, 1000);
    } else if (level == 2) {
        let seconds = 90;
        timerInterval = setInterval(function() {
            if (isPaused) {
                return;
            }
            if (seconds === 0) {
                clearInterval(timerInterval);
                timer.textContent = "Time's up!";
                checkForGameOver();
                return;
            }
            seconds--;
            
            let displayMinutes = Math.floor(seconds / 60);
            let displaySeconds = seconds % 60;
            displayMinutes = displayMinutes < 10 ? "0" + displayMinutes : displayMinutes;
            displaySeconds = displaySeconds < 10 ? "0" + displaySeconds : displaySeconds;
            // console.log(displayMinutes + ":" + displaySeconds);
            timer.textContent = displayMinutes + ":" + displaySeconds;
        }, 1000);
    }

}