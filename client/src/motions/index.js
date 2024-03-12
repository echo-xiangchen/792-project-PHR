// Object defining variants for dropdown animation
const dropdown = {
    itemVariant: {
        open: {
            // Animation properties for open state
            opacity: 1,
            y: 0,
            transition: { type: "spring", stiffness: 300, damping: 24 }
        },
        closed: {
            // Animation properties for closed state
            opacity: 0,
            y: 20,
            transition: { duration: 0.2 }
        }
    },
    ulVariant: {
        open: {
            // Animation properties for open state
            clipPath: "inset(0% 0% 0% 0% round 10px)",
            transition: {
                type: "spring",
                bounce: 0,
                duration: 0.7,
                delayChildren: 0.3,
                staggerChildren: 0.05
            }
        },
        closed: {
            // Animation properties for closed state
            clipPath: "inset(10% 50% 90% 50% round 10px)",
            transition: {
                type: "spring",
                bounce: 0,
                duration: 0.3
            }
        }
    }
};

// Object defining variants for sidebar animation
const sideBar = {
    open: (height = 1000) => ({
        // Animation properties for open state
        clipPath: `circle(${height * 2 + 200}px at 40px 40px)`,
        transition: {
            type: "spring",
            stiffness: 20,
            restDelta: 2
        }
    }),
    closed: {
        // Animation properties for closed state
        clipPath: "circle(30px at 40px 40px)",
        transition: {
            delay: 0.5,
            type: "spring",
            stiffness: 400,
            damping: 40
        }
    }
};

// Exporting the dropdown object for use in other parts of the application
export { 
    dropdown,
    sideBar
};
